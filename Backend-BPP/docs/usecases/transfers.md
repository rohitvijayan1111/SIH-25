Got it ✅ — you’re asking for **API endpoint use cases** built around your `transfers` table (not just the DB column mapping).
Here’s a **developer-style documentation** of possible **endpoint use cases** for `Transfers`:

---

# 🔹 **Transfers API – Endpoint Use Cases**

### 1️⃣ **Create Transfer Record**

**Endpoint:**
`POST /api/transfers`

**Purpose:**
Record a new handover of goods between supply chain actors (Farmer → FPO → Logistics → Retailer).

**Request Body Example:**

```json
{
  "batch_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
  "from_actor": "Farmer Ajith",
  "to_actor": "FPO-07",
  "quantity_kg": 120,
  "location_name": "Village Collection Center",
  "geo_lat": 12.9716,
  "geo_lon": 77.5946
}
```

**Use Cases:**

* Farmer delivers produce to FPO.
* FPO hands over to logistics partner.
* Logistics completes delivery to retailer.
* Partial batch transfers (split shipments).

---

### 2️⃣ **Fetch Transfer History for a Batch**

**Endpoint:**
`GET /api/transfers/batch/:batch_id`

**Purpose:**
Retrieve **all transfer records** linked to a given batch for full traceability.

**Response Example:**

```json
[
  {
    "from_actor": "Farmer Ajith",
    "to_actor": "FPO-07",
    "quantity_kg": 120,
    "location_name": "Village Collection Center",
    "geo_lat": 12.9716,
    "geo_lon": 77.5946,
    "timestamp": "2025-09-18T10:30:00Z",
    "chain_tx": "0xabc123..."
  },
  {
    "from_actor": "FPO-07",
    "to_actor": "ColdChainLogistics",
    "quantity_kg": 100,
    "location_name": "Chennai Warehouse",
    "geo_lat": 13.0827,
    "geo_lon": 80.2707,
    "timestamp": "2025-09-19T08:10:00Z",
    "chain_tx": "0xdef456..."
  }
]
```

**Use Cases:**

* ONDC `on_track` API → fetch farm-to-fork journey.
* Buyers auditing product authenticity.
* Regulators validating compliance.

---

### 3️⃣ **Fetch Latest Transfer Event**

**Endpoint:**
`GET /api/transfers/latest/:batch_id`

**Purpose:**
Get the **most recent transfer record** for real-time tracking.

**Use Cases:**

* Show buyer where the product is “right now” on ONDC buyer app.
* Retailer checks current batch location before accepting delivery.

---

### 4️⃣ **Track Transfer by Actor**

**Endpoint:**
`GET /api/transfers/actor/:actor_name`

**Purpose:**
Retrieve all transfers initiated or received by a particular actor.

**Use Cases:**

* FPO wants to see all farmer deliveries for the week.
* Logistics company audits all consignments received.
* Farmer checks if their batch has reached the retailer.

---

### 5️⃣ **Verify Transfer on Blockchain**

**Endpoint:**
`GET /api/transfers/:transfer_id/verify`

**Purpose:**
Cross-check transfer record against blockchain transaction hash (`chain_tx`).

**Use Cases:**

* Buyer validates that a claimed transfer actually exists on-chain.
* Certification body ensures the journey is not tampered with.

---

### 6️⃣ **Update Transfer (Correction/Exception Handling)**

**Endpoint:**
`PUT /api/transfers/:id`

**Purpose:**
Correct transfer details (only before blockchain confirmation).

**Use Cases:**

* Adjust wrong quantity recorded.
* Update location if GPS mismatch.
* Mark goods as **lost/damaged** before blockchain finalization.

---

### 7️⃣ **Delete Transfer Record**

**Endpoint:**
`DELETE /api/transfers/:id`

**Purpose:**
Remove erroneous records (only soft delete or before blockchain finalization).

**Use Cases:**

* Wrong batch linked to transfer.
* Test entries clean-up.

---

⚡ **Summary:**
Your `Transfers` API will handle:

* **Recording** (`POST`)
* **Tracing** (`GET by batch, actor, latest`)
* **Verifying** (via blockchain `chain_tx`)
* **Correcting/Deleting** (exception handling)

This covers **ONDC logistics → farm-to-fork journey**, **audit**, and **live buyer tracking**.

---

👉 Do you want me to also **map each of these endpoints to ONDC events** (`track`, `on_track`, etc.) so that it directly fits into your ONDC integration flow?
