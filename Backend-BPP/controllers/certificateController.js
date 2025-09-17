const pool = require("../config/db");
const { v4: uuidv4, validate: isUuid } = require("uuid");


let ipfs;
(async () => {
  const { create } = await import("ipfs-http-client");
  ipfs = create({ url: "https://ipfs.infura.io:5001/api/v0" });
})();



// Attach Certificate to a Batch
const addCertificate = async (req, res) => {
  try {
    const { batch_id } = req.params;
    const {
      cert_id,
      cert_hash,
      issuer_id,
      issuer_name,
      issued_at,
      file_cid,
      chain_tx
    } = req.body;

    if (!cert_hash || !batch_id) {
      return res.status(400).json({ error: "batch_id and cert_hash are required" });
    }

    const query = `
      INSERT INTO batch_certificates 
        (batch_id, cert_id, cert_hash, issuer_id, issuer_name, issued_at, file_cid, chain_tx) 
      VALUES ($1,$2,$3,$4,$5,$6,$7,$8) 
      RETURNING *;
    `;

    const values = [
      batch_id,
      cert_id,
      cert_hash,
      issuer_id,
      issuer_name,
      issued_at,
      file_cid,
      chain_tx
    ];

    const result = await pool.query(query, values);

    return res.status(201).json({
      message: "Certificate successfully attached to batch",
      certificate: result.rows[0],
    });
  } catch (error) {
    console.error("Error inserting certificate:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};



// Verify Certificate Authenticity
const verifyCertificate = async (req, res) => {
  try {
    const { batch_id, cert_id } = req.params;
    if (!isUuid(batch_id) || !isUuid(cert_id)) {
  console.log("Invalid UUID! Abort operation.");
  return res.status(400).json({ error: "Invalid issuer_id UUID" });
} 

    const query = `
      SELECT cert_id, cert_hash, chain_tx 
      FROM batch_certificates 
      WHERE batch_id = $1 AND cert_id = $2
      LIMIT 1;
    `;

    const result = await pool.query(query, [batch_id, cert_id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ error: "Certificate not found" });
    }

    const cert = result.rows[0];
    const isHashValid = cert.cert_hash && cert.cert_hash.length > 0;
    
    const isChainValid = cert.chain_tx && cert.chain_tx.startsWith("0x");
    const status = isHashValid && isChainValid ? "valid" : "invalid";

    return res.json({
      batch_id,
      cert_id,
      cert_hash: cert.cert_hash,
      chain_tx: cert.chain_tx,
      status
    });

  } catch (error) {
    console.error("Error verifying certificate:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};



// 1️⃣ Fetch all certificates for a batch
const getAllCertificates = async (req, res) => {
  try {
    const { batch_id } = req.params;

    const query = `SELECT * FROM batch_certificates WHERE batch_id = $1;`;
    const result = await pool.query(query, [batch_id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "No certificates found for this batch" });
    }

    return res.json({ batch_id, certificates: result.rows });
  } catch (error) {
    console.error("Error fetching certificates:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// 2️⃣ Fetch specific certificate details
const getCertificateById = async (req, res) => {
  try {
    const { batch_id, cert_id } = req.params;

    const query = `
      SELECT * FROM batch_certificates 
      WHERE batch_id = $1 AND cert_id = $2
      LIMIT 1;
    `;
    const result = await pool.query(query, [batch_id, cert_id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Certificate not found" });
    }

    return res.json(result.rows[0]);
  } catch (error) {
    console.error("Error fetching certificate:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};

// 3️⃣ Direct download of certificate (via IPFS file_cid)
const downloadCertificateFile = async (req, res) => {
  try {
    const { batch_id, cert_id } = req.params;

    const query = `
      SELECT file_cid FROM batch_certificates 
      WHERE batch_id = $1 AND cert_id = $2
      LIMIT 1;
    `;
    const result = await pool.query(query, [batch_id, cert_id]);

    if (result.rows.length === 0) {
      return res.status(404).json({ message: "Certificate file not found" });
    }

    const { file_cid } = result.rows[0];

    if (!file_cid) {
      return res.status(400).json({ message: "No file CID associated with this certificate" });
    }

    
    const fileUrl = `https://ipfs.io/ipfs/${file_cid}`;

    // Option 1: Just return the URL
    return res.json({ download_url: fileUrl });

    // Option 2 (Uncomment if you want to stream file directly)
    /*
    const response = await axios.get(fileUrl, { responseType: "arraybuffer" });
    res.setHeader("Content-Type", "application/pdf");
    res.send(response.data);
    */
  } catch (error) {
    console.error("Error downloading certificate file:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};


// /**
//  * Upload Certificate File (PDF, Lab Reports) for a Batch

const uploadCertificate = async (req, res) => {
  try {
    const { batch_id } = req.params;
    const { issuer_name, issued_at } = req.body;

    if (!req.file) {
      return res.status(400).json({ error: "Certificate file is required" });
    }

    const buffer = req.file.buffer;
    if (!ipfs) {
      return res.status(500).json({ error: "IPFS client not ready" });
    }

    const result = await ipfs.add(buffer);
    const file_cid = result.cid.toString();

    const query = `
      INSERT INTO batch_certificates (batch_id, issuer_name, issued_at, file_cid)
      VALUES ($1, $2, $3, $4)
      RETURNING *
    `;
    const values = [
      batch_id,
      issuer_name || "Unknown Issuer",
      issued_at || new Date().toISOString(),
      file_cid,
    ];

    const { rows } = await pool.query(query, values);

    res.status(201).json({
      message: "Certificate uploaded successfully",
      certificate: rows[0],
      file_cid,
      ipfs_url: `https://ipfs.io/ipfs/${file_cid}`,
    });
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: "Server error while uploading certificate" });
  }
};

/**
 * Validate certificates before listing a batch
 * POST /api/batches/:batch_id/certificates/validate
 */
const validateCertificates = async (req, res) => {
  try {
    const { batch_id } = req.params;

    const query = `
      SELECT cert_id, cert_hash, chain_tx, issued_at
      FROM batch_certificates
      WHERE batch_id = $1
    `;
    const { rows } = await pool.query(query, [batch_id]);

    if (rows.length === 0) {
      return res.status(400).json({
        status: "invalid",
        reason: "No certificates found for this batch"
      });
    }

    const validCertificates = [];
    const now = new Date();

    for (let cert of rows) {
      let isValid = true;

      if (!cert.chain_tx || cert.chain_tx.length < 5) {
        isValid = false;
      }

      if (cert.issued_at && new Date(cert.issued_at) > now) {
        isValid = false;
      }

      // (c) Optional: expiry validation (add expiry column in future)
      // if (cert.expiry_date && new Date(cert.expiry_date) < now) {
      //   isValid = false;
      // }

      if (isValid) {
        validCertificates.push(cert.cert_id);
      }
    }

    if (validCertificates.length > 0) {
      return res.status(200).json({
        status: "valid",
        certificates: validCertificates
      });
    } else {
      return res.status(400).json({
        status: "invalid",
        reason: "No valid certificates found"
      });
    }

  } catch (err) {
    console.error("Error validating certificates:", err);
    res.status(500).json({ error: "Server error while validating certificates" });
  }
};
module.exports = {addCertificate,verifyCertificate,getAllCertificates, getCertificateById,downloadCertificateFile,uploadCertificate,validateCertificates};