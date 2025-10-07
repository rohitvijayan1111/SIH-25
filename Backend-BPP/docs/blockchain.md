🔹 Blockchain / Traceability Tables
-- 11. Batches
CREATE TABLE batches (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),      -- Unique batch identifier (auto-generated)
    batch_code VARCHAR(100) UNIQUE,                     -- Human-readable batch code (e.g., "BATCH-001")

    product_id UUID NOT NULL,                           -- FK → products(id)
    farmer_id UUID NOT NULL,                            -- FK → farmers(id)
    parent_batch_id UUID REFERENCES batches(id) ON DELETE SET NULL,  -- Link to parent batch (for merges/splits)

    initial_qty_kg NUMERIC NOT NULL,                    -- Original quantity of the batch (in kilograms)
    current_qty_kg NUMERIC NOT NULL,                    -- Remaining quantity after sales/transfers
    price_per_unit NUMERIC(10,2) DEFAULT 0,             -- Price per unit (e.g., ₹/kg or ₹/L)
    unit VARCHAR(10) DEFAULT 'KG',                      -- Measurement unit (e.g., KG, L, TON)

    harvest_date TIMESTAMP,                             -- Date when the crop was harvested
    geo_lat DOUBLE PRECISION,                           -- Latitude of the farm location
    geo_lon DOUBLE PRECISION,                           -- Longitude of the farm location
    location_name TEXT,                                 -- Human-readable farm or location name

    organic BOOLEAN DEFAULT FALSE,                      -- Whether the batch is organically certified
    meta_hash TEXT,                                     -- IPFS or blockchain metadata hash for verification
    chain_tx TEXT,                                      -- Blockchain transaction reference (if applicable)

    status VARCHAR(30) DEFAULT 'PENDING',               -- Batch status (e.g., LISTED, LOCKED, VERIFIED)
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,     -- Creation timestamp
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP      -- Last update timestamp
);


-- 12. Batch certificates
CREATE TABLE batch_certificates (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    batch_id UUID NOT NULL,
    cert_id VARCHAR(100),
    cert_hash TEXT NOT NULL,
    issuer_id UUID,
    issuer_name VARCHAR(200),
    issued_at TIMESTAMP,
    file_cid TEXT,
    chain_tx TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (batch_id) REFERENCES batches(id) ON DELETE CASCADE
);

-- 13. Transfers
CREATE TABLE transfers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    batch_id UUID NOT NULL,
    from_actor TEXT,
    to_actor TEXT,
    quantity_kg NUMERIC NOT NULL,
    location_name TEXT,
    geo_lat DOUBLE PRECISION,
    geo_lon DOUBLE PRECISION,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    chain_tx TEXT,
    FOREIGN KEY (batch_id) REFERENCES batches(id) ON DELETE CASCADE
);

-- 14. Chain events
CREATE TABLE chain_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type VARCHAR(50),
    entity_type VARCHAR(50),
    entity_id UUID,
    details JSONB,
    tx_hash TEXT,
    created_at TIMESTAMP DEFAULT CU RRENT_TIMESTAMP
);

-- 15. Payments
CREATE TABLE payments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID,
    batch_id UUID,
    payer TEXT,
    payee TEXT,
    amount DECIMAL(12,2),
    currency VARCHAR(10) DEFAULT 'INR',
    payment_method VARCHAR(50),
    payment_status VARCHAR(30) DEFAULT 'INITIATED',
    proof_cid TEXT,
    chain_tx TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (batch_id) REFERENCES batches(id)
);

-- 16. Escrows
CREATE TABLE escrows (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    escrow_ref VARCHAR(100) UNIQUE,
    order_id UUID,
    amount DECIMAL(12,2),
    locked BOOLEAN DEFAULT FALSE,
    released BOOLEAN DEFAULT FALSE,
    locked_at TIMESTAMP,
    released_at TIMESTAMP,
    chain_tx TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(id)
);



CREATE MATERIALIZED VIEW inventory_view AS
SELECT
  b.id AS batch_id,
  b.batch_code,
  p.id AS product_id,
  p.name AS product_name,
  p.type AS product_type,
  b.farmer_id,
  f.name AS farmer_name,
  b.current_qty_kg AS available_qty,
  b.unit,
  b.organic,  -- NEW COLUMN ADDED
  COALESCE(pb.price_per_unit, 0) AS price_per_unit,
  pb.quantity AS batch_quantity,
  pb.manufactured_on,
  pb.expiry_date,
  b.harvest_date,
  b.location_name,
  b.geo_lat,
  b.geo_lon,
  b.status,
  b.meta_hash,
  b.chain_tx
FROM batches b
JOIN products p ON p.id = b.product_id
JOIN farmers f ON f.id = b.farmer_id
LEFT JOIN product_batches pb ON pb.product_id = p.id
WHERE b.status = 'LISTED'
  AND b.current_qty_kg > 0
WITH DATA;



Ah — the error is clear 👇

> `ERROR: relation "buyers" does not exist`

This means PostgreSQL couldn’t find a table named **`buyers`** (or one of the other referenced tables).
To fix this, you have **two options** depending on your setup.

---

### ✅ **Option 1: Create a simple `middlemen` table first**

If your intention was to link this purchase to **middlemen**, not “buyers”,
then replace the foreign key reference from `buyers` → `middlemen`.

Here’s the corrected and **working** version 👇

```sql
CREATE TABLE middlemen (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE middlemen_purchase (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),

    -- 🔸 Basic Details
    purchase_code VARCHAR(100) UNIQUE NOT NULL,    -- Unique purchase reference
    middleman_id UUID NOT NULL,                    -- Buyer (middleman)
    farmer_id UUID NOT NULL,                       -- Seller (farmer)
    batch_id UUID NOT NULL,                        -- Purchased batch
    product_id UUID NOT NULL,                      -- Product linked to batch

    -- 🔸 Transaction Details
    quantity_kg NUMERIC NOT NULL CHECK (quantity_kg > 0),
    price_per_kg DECIMAL(10,2) NOT NULL CHECK (price_per_kg >= 0),
    total_price DECIMAL(12,2) GENERATED ALWAYS AS (quantity_kg * price_per_kg) STORED,
    currency VARCHAR(10) DEFAULT 'INR',

    -- 🔸 Status & Mode
    payment_status VARCHAR(30) DEFAULT 'PENDING',  -- PENDING | PAID | FAILED
    delivery_status VARCHAR(30) DEFAULT 'PENDING', -- PENDING | SHIPPED | DELIVERED
    payment_mode VARCHAR(50),                      -- ESCROW | CASH | UPI | BANK

    -- 🔸 Blockchain Linkage
    chain_tx TEXT,                                 -- Blockchain transaction hash
    proof_cid TEXT,                                -- IPFS proof (invoice, etc.)

    -- 🔸 Timestamps
    purchase_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    -- 🔸 Foreign Keys
    FOREIGN KEY (middleman_id) REFERENCES middlemen(id) ON DELETE CASCADE,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES batches(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
```

---

### ✅ **Option 2: If you already have a `buyers` table**

If your schema already uses a **`buyers`** table instead of `middlemen`,
then **create the buyers table first** (before creating this one).

Example:

```sql
CREATE TABLE buyers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    contact_number VARCHAR(20),
    email VARCHAR(100),
    location VARCHAR(150),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

Then re-run your original `middlemen_purchase` query.

---

Would you like me to make a **simplified version of the `middlemen_purchase` table** (only essential columns for faster testing)?





Got it, Ajith 👍
If we look at ONDC’s flow (**Discovery → Order → Fulfillment → Settlement → Post-order**), each of your **Blockchain / Traceability tables** maps naturally to ONDC-based use cases.

Here’s a structured list of **ONDC-aligned use cases** for each table:

---

## 🔹 **11. Batches**

👉 Core entity for ONDC **Discovery** & **Catalog Management**

* Farmer/producer creates a new batch after harvest (`BatchCreated`)
* Update batch status → `PENDING → VERIFIED → LISTED` for ONDC exposure
* Split/merge batches for different buyers (`parent_batch_id`)
* Track batch location & harvest details for provenance
* Anchor `meta_hash` (IPFS/JSON) on blockchain for audit
* Use case: ONDC `search` → fetch available stock from **`inventory_view`**

---

## 🔹 **12. Batch Certificates**

👉 Supports ONDC **Trust & Quality Assurance**

* Attach certification (Organic, FSSAI, Fair Trade) to a batch
* Verify certificate authenticity via blockchain hash (`cert_hash`)
* Buyers can request quality certificates via ONDC `get/cancel` APIs
* Inspectors upload digital certificates (PDFs, lab reports) with `file_cid`
* Smart contract validation before batch is `LISTED`

---

## 🔹 **13. Transfers**

👉 Maps to ONDC **Logistics & Fulfillment**

* Record farmer → FPO → logistics → retailer transfers (`TransferRecorded`)
* Track GPS coordinates (`geo_lat`, `geo_lon`) for live traceability
* Support split shipments (part of batch transferred)
* Buyers can audit full “farm-to-fork” journey through ONDC’s `track` API
* Use case: ONDC `on_track` → fetch blockchain-verified transfer events

---

## 🔹 **14. Chain Events**

👉 Global **Audit & Eventing Layer** for ONDC

* Record all key events: `BatchCreated`, `TransferRecorded`, `OrderCreated`, `PaymentLocked`, `PaymentReleased`
* Expose event history to buyers/sellers for transparency
* Power ONDC’s **trust dashboard** (immutable audit logs)
* Use case: ONDC `on_status` → show blockchain event trail

---

## 🔹 **15. Payments**

👉 Maps to ONDC **Settlement & Payment** flow

* Lock payment when buyer places an order (`payment_status = INITIATED/LOCKED`)
* Release funds upon delivery confirmation (`RELEASED`)
* Handle disputes → refunds (`REFUNDED`)
* Store payment proof receipts in IPFS (`proof_cid`)
* Use case: ONDC `on_settle` → confirm blockchain payment settlement

---

## 🔹 **16. Escrows**

👉 Optional but useful for ONDC **Dispute Management**

* Lock buyer’s payment into escrow until delivery is confirmed
* Release to seller only after ONDC `on_confirm` event
* Handle refund scenarios (`released = FALSE`)
* Provide confidence for both buyer & seller
* Use case: ONDC `on_cancel` → auto refund escrow

---

## 🔹 **Materialized View – inventory\_view**

👉 Powers ONDC **Discovery API**

* Flattened view for ONDC adapters to query live stock, price, farmer details
* Ensure only `LISTED` + `available_qty > 0` batches appear
* Buyers see latest availability & pricing instantly
* Use case: ONDC `search` → query **inventory\_view** for real-time catalog

---

✅ In short:

* **Discovery:** `batches`, `inventory_view`, `batch_certificates`
* **Order & Fulfillment:** `transfers`, `chain_events`
* **Settlement:** `payments`, `escrows`
* **Post-order trust:** `chain_events`, `batch_certificates`

---

Do you want me to **expand each use case into “Actor → Action → System Response” format** (like a proper use case doc), or keep them at this ONDC-mapped summary level?
