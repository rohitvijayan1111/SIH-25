Got it 👍 You want me to make the **use cases & endpoints** section more detailed.
Here’s an expanded version just for the **Batch Certificates use cases + API endpoints**:

---

## 🔹 **Batch Certificates – Use Cases & Endpoints**

### 1️⃣ **Attach Certification to a Batch**

* **Use Case**: Farmers, producers, or certifying authorities attach certificates (Organic, FSSAI, Fair Trade, ISO, Lab Test Reports) to a batch.
* **Endpoint**:

  ```
  POST /batches/{batch_id}/certificates
  ```

  **Payload Example**:

  ```json
  {
    "cert_id": "FSSAI-5678",
    "cert_hash": "0xabc123...",
    "issuer_id": "uuid-issuer-01",
    "issuer_name": "FSSAI India",
    "issued_at": "2025-09-01T10:20:00Z",
    "file_cid": "bafybeigdyr...",
    "chain_tx": "0xdef456..."
  }
  ```

  **Result**: Certificate linked to the batch & hash anchored on blockchain.

---

### 2️⃣ **Verify Certificate Authenticity via Blockchain Hash**

* **Use Case**: Buyers, sellers, and regulators verify if the certificate file is authentic (untampered).
* **Endpoint**:

  ```
  GET /batches/{batch_id}/certificates/{cert_id}/verify
  ```

  **System Action**:

  * Compare uploaded file hash with `cert_hash`.
  * Cross-check `chain_tx` on blockchain.
  * Return `valid / invalid`.

---

### 3️⃣ **Buyers Request Certificates via ONDC APIs**

* **Use Case**: Buyers want to review quality certificates before confirming orders.
* **Endpoints**:

  * ```
    GET /batches/{batch_id}/certificates
    ```

    → Fetch all certificates attached to a batch.
  * ```
    GET /batches/{batch_id}/certificates/{cert_id}
    ```

    → Fetch specific certificate details & download file (via `file_cid`).
  * ```
    GET /batches/{batch_id}/certificates/download/{cert_id}
    ```

    → Direct download of PDF / Lab report.

---

### 4️⃣ **Inspectors Upload Digital Certificates (PDFs, Lab Reports)**

* **Use Case**: Government labs, certifying agencies, or auditors upload certificate files.
* **Endpoint**:

  ```
  POST /batches/{batch_id}/certificates/upload
  ```

  **Payload Example**:

  ```json
  {
    "file": "<base64-encoded-pdf>",
    "meta": {
      "issuer_name": "Organic India Certification Board",
      "issued_at": "2025-09-10T12:00:00Z"
    }
  }
  ```

  **Result**: File stored in IPFS → `file_cid` auto-linked in DB.

---

### 5️⃣ **Smart Contract Validation Before Batch Listing**

* **Use Case**: Before a batch goes `LISTED` on ONDC, system ensures valid certificates exist.
* **Endpoint**:

  ```
  POST /batches/{batch_id}/certificates/validate
  ```

  **System Action**:

  * Check if at least one valid certificate exists.
  * Verify hash (`cert_hash`) matches blockchain proof (`chain_tx`).
  * Validate issue date (`issued_at`) and expiry (if applicable).
  * Return:

    ```json
    {
      "status": "valid",
      "certificates": ["FSSAI-5678", "ORG-7890"]
    }
    ```

---

👉 These endpoints ensure **end-to-end trust, certificate traceability, and API-driven compliance** inside the ONDC ecosystem.

---

Do you want me to **group these endpoints into Buyer APIs, Seller APIs, and Inspector/Issuer APIs** for more clarity (like ONDC protocol separation)?
