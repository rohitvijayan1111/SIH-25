const express = require("express");
const multer = require("multer");
const { addCertificate,verifyCertificate,getAllCertificates, getCertificateById,downloadCertificateFile,uploadCertificate,validateCertificates} = require("../controllers/certificateController");
const router = express.Router();

// Multer setup - store file in memory (buffer)
const storage = multer.memoryStorage();
const upload = multer({ storage });
// Simple endpoint → POST /certificate/:batch_id
router.post("/:batch_id", addCertificate);

// Verify Certificate → GET /api/certificate/:batch_id/:cert_id/verify
router.get("/:batch_id/:cert_id/verify", verifyCertificate);


// Get all certificates for a batch
router.get("/:batch_id", getAllCertificates);

// Get specific certificate details
router.get("/:batch_id/:cert_id", getCertificateById);

// Download certificate file (IPFS link or stream)
router.get("/:batch_id/:cert_id/download", downloadCertificateFile);

// 📌 Inspectors Upload Digital Certificates (PDFs, Lab Reports)
// POST /api/batches/:batch_id/certificates/upload
router.post(
  "/batches/:batch_id/certificates/upload",
  upload.single("file"),   // middleware to handle file upload
  uploadCertificate        // your controller
);

// POST /api/batches/:batch_id/certificates/validate
router.post("/batches/:batch_id/certificates/validate", validateCertificates);

module.exports = router;
