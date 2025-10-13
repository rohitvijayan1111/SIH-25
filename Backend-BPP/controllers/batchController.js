const db = require('../config/db');

// 1️⃣ Farmer Creates a New Batch (BatchCreated)
const createBatch = async (req, res) => {
  try {
    let {
      product_id,
      farmer_id,
      initial_qty_kg,
      unit,
      harvest_date,
      geo_lat,
      geo_lon,
      location_name,
      meta_hash,
      organic,
      price_per_unit, // NEW FIELD
    } = req.body;

    // clean ids (if prefixed)
    farmer_id = farmer_id.replace(/^farmer-/, '');
    product_id = product_id.replace(/^product-/, '');

    const batch_code = `BATCH-${Date.now()}`;

    const query = `
      INSERT INTO batches 
        (batch_code, product_id, farmer_id, initial_qty_kg, current_qty_kg, unit, 
         harvest_date, geo_lat, geo_lon, location_name, meta_hash, status, organic, price_per_unit)
      VALUES ($1,$2,$3,$4,$4,$5,$6,$7,$8,$9,$10,'PENDING',$11,$12)
      RETURNING *;
    `;

    const values = [
      batch_code,
      product_id,
      farmer_id,
      initial_qty_kg,
      unit || 'KG',
      harvest_date,
      geo_lat,
      geo_lon,
      location_name,
      meta_hash,
      organic || false,
      price_per_unit || 0,
    ];

    const result = await db.query(query, values);

    console.log('📢 Blockchain Event: BatchCreated', {
      batch_id: result.rows[0].id,
      batch_code,
      product_id,
      farmer_id,
      qty: initial_qty_kg,
      price_per_unit: result.rows[0].price_per_unit,
      organic: result.rows[0].organic,
    });

    res.status(201).json({
      message: 'Batch created successfully',
      batch: result.rows[0],
    });
  } catch (err) {
    console.error('Error creating batch:', err.message);
    res.status(500).json({ error: 'Failed to create batch' });
  }
};

// 2️⃣ Update Batch Status
const updateStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    const allowedStatuses = [
      'PENDING',
      'VERIFIED',
      'LISTED',
      'LOCKED',
      'INVALIDATED',
    ];

    if (!allowedStatuses.includes(status)) {
      return res.status(400).json({
        error: `Invalid status. Allowed: ${allowedStatuses.join(', ')}`,
      });
    }

    const query = `
      UPDATE batches
      SET status = $1, updated_at = CURRENT_TIMESTAMP
      WHERE id = $2
      RETURNING *;
    `;

    const result = await db.query(query, [status, id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Batch not found' });
    }

    const updatedBatch = result.rows[0];

    console.log('📢 Blockchain Event:', {
      event: `Batch${status.charAt(0) + status.slice(1).toLowerCase()}`,
      batch_id: id,
      status,
    });

    res.json({
      message: `Batch status updated to ${status}`,
      batch: updatedBatch,
    });
  } catch (err) {
    console.error('Error updating batch status:', err.message);
    res.status(500).json({ error: 'Failed to update batch status' });
  }
};

// 3️⃣ Split Batch
const splitBatch = async (req, res) => {
  const client = await db.connect();
  try {
    const { id } = req.params;
    const { split_qty, unit } = req.body;

    await client.query('BEGIN');

    const parentResult = await client.query(
      'SELECT * FROM batches WHERE id = $1',
      [id]
    );
    if (parentResult.rows.length === 0) {
      return res.status(404).json({ error: 'Parent batch not found' });
    }

    const parent = parentResult.rows[0];

    if (split_qty > parent.current_qty_kg) {
      return res.status(400).json({
        error: `Split quantity exceeds available stock (${parent.current_qty_kg} ${parent.unit})`,
      });
    }

    await client.query(
      'UPDATE batches SET current_qty_kg = current_qty_kg - $1, updated_at = CURRENT_TIMESTAMP WHERE id = $2',
      [split_qty, id]
    );

    const childResult = await client.query(
      `
      INSERT INTO batches 
        (product_id, farmer_id, initial_qty_kg, current_qty_kg, unit, harvest_date,
         geo_lat, geo_lon, location_name, meta_hash, status, parent_batch_id, organic, price_per_unit)
      VALUES ($1,$2,$3,$3,$4,$5,$6,$7,$8,$9,'PENDING',$10,$11,$12)
      RETURNING *;
      `,
      [
        parent.product_id,
        parent.farmer_id,
        split_qty,
        unit || parent.unit,
        parent.harvest_date,
        parent.geo_lat,
        parent.geo_lon,
        parent.location_name,
        parent.meta_hash,
        parent.id,
        parent.organic,
        parent.price_per_unit, // 🔥 carry parent price
      ]
    );

    const childBatch = childResult.rows[0];
    await client.query('COMMIT');

    console.log('📢 Blockchain Event: BatchSplit', {
      parent_batch_id: parent.id,
      child_batch_id: childBatch.id,
      split_qty,
    });

    res.status(201).json({
      message: 'Batch split successfully',
      parent_batch: {
        id: parent.id,
        remaining_qty: parent.current_qty_kg - split_qty,
      },
      child_batch: childBatch,
    });
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Error splitting batch:', err.message);
    res.status(500).json({ error: 'Failed to split batch' });
  } finally {
    client.release();
  }
};

// 4️⃣ Merge Batches
const mergeBatches = async (req, res) => {
  const client = await db.connect();
  try {
    const { batch_ids, new_batch_code } = req.body;
    if (!batch_ids || batch_ids.length < 2)
      return res
        .status(400)
        .json({ error: 'Provide at least two batches to merge' });

    await client.query('BEGIN');

    const result = await client.query(
      `SELECT * FROM batches WHERE id = ANY($1::uuid[])`,
      [batch_ids]
    );

    if (result.rows.length !== batch_ids.length)
      return res.status(404).json({ error: 'One or more batches not found' });

    const parents = result.rows;
    const totalQty = parents.reduce(
      (sum, b) => sum + Number(b.current_qty_kg),
      0
    );
    const mergedOrganic = parents.every((b) => b.organic);
    const avgPrice =
      parents.reduce((sum, b) => sum + Number(b.price_per_unit), 0) /
      parents.length; // 🔥 average price

    await client.query(
      `UPDATE batches SET status = 'LOCKED', updated_at = CURRENT_TIMESTAMP WHERE id = ANY($1::uuid[])`,
      [batch_ids]
    );

    const mergedResult = await client.query(
      `
      INSERT INTO batches
        (batch_code, product_id, farmer_id, initial_qty_kg, current_qty_kg, unit,
         harvest_date, geo_lat, geo_lon, location_name, meta_hash, status, organic, price_per_unit)
      VALUES ($1,$2,$3,$4,$4,$5,$6,$7,$8,$9,$10,'PENDING',$11,$12)
      RETURNING *;
      `,
      [
        new_batch_code || `BATCH-MERGED-${Date.now()}`,
        parents[0].product_id,
        parents[0].farmer_id,
        totalQty,
        parents[0].unit,
        parents[0].harvest_date,
        parents[0].geo_lat,
        parents[0].geo_lon,
        parents[0].location_name,
        parents[0].meta_hash,
        mergedOrganic,
        avgPrice,
      ]
    );

    const mergedBatch = mergedResult.rows[0];
    await client.query('COMMIT');

    console.log('📢 Blockchain Event: BatchMerged', {
      parent_batch_ids: batch_ids,
      merged_batch_id: mergedBatch.id,
      totalQty,
      avgPrice,
    });

    res.status(201).json({
      message: 'Batches merged successfully',
      merged_batch: mergedBatch,
      locked_parents: batch_ids,
    });
  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Error merging batches:', err.message);
    res.status(500).json({ error: 'Failed to merge batches' });
  } finally {
    client.release();
  }
};

// 4️⃣ Update Harvest/Location/Meta Info
const updateBatch = async (req, res) => {
  try {
    const { id } = req.params; // batch_id
    const { geo_lat, geo_lon, location_name, meta_hash, organic } = req.body;

    const fields = [];
    const values = [];
    let idx = 1;

    if (geo_lat !== undefined) {
      fields.push(`geo_lat = $${idx++}`);
      values.push(geo_lat);
    }
    if (geo_lon !== undefined) {
      fields.push(`geo_lon = $${idx++}`);
      values.push(geo_lon);
    }
    if (location_name !== undefined) {
      fields.push(`location_name = $${idx++}`);
      values.push(location_name);
    }
    if (meta_hash !== undefined) {
      fields.push(`meta_hash = $${idx++}`);
      values.push(meta_hash);
    }

    if (fields.length === 0) {
      return res
        .status(400)
        .json({ error: 'No valid fields provided for update' });
    }
    if (organic !== undefined) {
      fields.push(`organic = $${idx++}`);
      values.push(organic);
    }

    fields.push(`updated_at = CURRENT_TIMESTAMP`);

    const query = `
      UPDATE batches
      SET ${fields.join(', ')}
      WHERE id = $${idx}
      RETURNING *;
    `;

    values.push(id);

    const result = await db.query(query, values);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: 'Batch not found' });
    }

    const updatedBatch = result.rows[0];

    console.log('📢 Blockchain Event: BatchUpdated', {
      batch_id: id,
      updated_fields: Object.keys(req.body),
    });

    res.json({
      message: 'Batch updated successfully',
      batch: updatedBatch,
    });
  } catch (err) {
    console.error('Error updating batch:', err.message);
    res.status(500).json({ error: 'Failed to update batch' });
  }
};

// Anchor metadata for a batch
const anchorMetadata = async (req, res) => {
  const { batchId } = req.params;
  const { meta_hash } = req.body;
  const updatedAt = new Date();

  if (!meta_hash) {
    return res.status(400).json({ error: 'meta_hash is required' });
  }

  try {
    const result = await db.query(
      `UPDATE batches
       SET meta_hash = $1,
           updated_at = $2
       WHERE id = $3
       RETURNING id, batch_code, product_id, farmer_id, meta_hash, updated_at`,
      [meta_hash, updatedAt, batchId]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Batch not found' });
    }

    const updatedBatch = result.rows[0];
    console.log(
      `✅ Blockchain Event: BatchAnchored - Batch ID: ${updatedBatch.id}, Meta Hash: ${updatedBatch.meta_hash}`
    );

    res.json({
      message: 'Metadata anchored successfully',
      batch: updatedBatch,
    });
  } catch (err) {
    console.error('Error anchoring metadata:', err);
    res.status(500).json({ error: 'Internal server error' });
  }
};

// GET /api/discovery
const getInventory = async (req, res) => {
  try {
    const { product_type, farmer_id, min_qty, product_name, product_id } =
      req.query;

    let query = `SELECT * FROM inventory_view WHERE 1=1`;
    const values = [];
    let idx = 1;

    if (product_type) {
      query += ` AND product_type = $${idx++}`;
      values.push(product_type);
    }

    if (farmer_id) {
      query += ` AND farmer_id = $${idx++}`;
      values.push(farmer_id);
    }

    if (min_qty) {
      query += ` AND available_qty >= $${idx++}`;
      values.push(Number(min_qty));
    }
    if (product_name) {
      query += ` AND LOWER(product_name) LIKE LOWER($${idx++})`;
      values.push(`%${product_name}%`); // partial case-insensitive match
    }
    if (product_id) {
      query += ` AND product_id = $${idx++}`;
      values.push(product_id);
    }
    query += ` ORDER BY available_qty DESC`;

    const result = await db.query(query, values);

    res.json({ inventory: result.rows });
  } catch (err) {
    console.error('Error fetching inventory:', err.message);
    res.status(500).json({ error: 'Failed to fetch inventory' });
  }
};
const getProduceProducts = async (req, res) => {
  try {
    // Adjust this WHERE clause to fit how your db categorizes produce
    // If you use category, change 'type' to 'category' below.
    const query = `
      SELECT id, name, type, unit, description
      FROM products
      WHERE type NOT IN ('grain', 'fruit', 'vegetable', 'pulse', 'cereal')
      ORDER BY name;
    `;
    const result = await db.query(query);

    res.status(200).json({
      products: result.rows,
    });
  } catch (err) {
    console.error('Error fetching produce products:', err.message);
    res.status(500).json({ error: 'Failed to fetch produce products' });
  }
};

const getBatchesbyFarmers = async (req, res) => {
  try {
    const { farmer_id } = req.params;
    const query = `SELECT batches.*,farmers.name as farmer_name,products.name as product_name
  from batches
  JOIN farmers on batches.farmer_id=farmers.id
  JOIN products ON batches.product_id=products.id
  where batches.farmer_id=$1`;
    const result = await db.query(query, [farmer_id]);
    res.status(200).json(result.rows);
  } catch (error) {
    // console.log()

    res.status(500).json({ error: error.message });
  }
};

// GET all batches (optionally filter by status)
const getAllBatches = async (req, res) => {
  try {
    const { status } = req.query; // Optionally filter by status
    let query = `SELECT * FROM batches`;
    const values = [];
    if (status) {
      query += ` WHERE status = $1`;
      values.push(status);
    }
    const result = await db.query(query, values);
    res.status(200).json({ inventory: result.rows });
  } catch (err) {
    console.error('Error fetching batches:', err.message);
    res.status(500).json({ error: 'Failed to fetch batches' });
  }
};

// controllers/batchController.js

// Get batches by product name with farmer and product details
const getBatchesByProductName = async (req, res) => {
  try {
    const { product_name } = req.params;

    const query = `
      SELECT 
        b.id,
        b.batch_code,
        b.product_id,
        b.farmer_id,
        b.current_qty_kg as available_qty,
        b.unit,
        b.price_per_unit,
        b.initial_qty_kg as batch_quantity,
        b.harvest_date,
        b.location_name,
        b.geo_lat,
        b.geo_lon,
        b.status,
        b.meta_hash,
        b.chain_tx,
        b.created_at,
        b.updated_at,
        
        -- Product details
        p.name as product_name,
        p.type as product_type,
        p.description as product_description,
        
        -- Farmer details
        f.name as farmer_name,
        f.phone as farmer_phone,
        f.farm_location as farmer_location,
        f.organic_certified,
        f.kyc_id as certifications

      FROM batches b
      LEFT JOIN products p ON b.product_id = p.id
      LEFT JOIN farmers f ON b.farmer_id = f.id
      WHERE LOWER(p.name) = LOWER($1)
        AND b.current_qty_kg > 0
      ORDER BY b.price_per_unit ASC, b.harvest_date DESC
    `;

    const { rows } = await db.query(query, [product_name]);

    if (!rows.length) {
      return res.status(404).json({
        success: false,
        message: 'No available batches found for this product',
      });
    }

    res.json({
      success: true,
      data: rows,
      total_batches: rows.length,
      message: `Found ${rows.length} available batches`,
    });
  } catch (err) {
    console.error('Error fetching batches by product name:', err);
    res.status(500).json({
      success: false,
      error: 'Server error',
      message: err.message,
    });
  }
};

module.exports = {
  createBatch,
  updateStatus,
  splitBatch,
  mergeBatches,
  updateBatch,
  anchorMetadata,
  getInventory,
  getProduceProducts,
  getBatchesbyFarmers,
  getAllBatches,
  getBatchesByProductName,
};
