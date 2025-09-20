Perfect 👌 Let’s make **11. Batches** very **detailed and beginner-friendly**, so you (or anyone reading) can clearly understand how it works in an ONDC + Blockchain context.

---

# 🔹 **11. Batches**

The **`batches`** table is the **heart of traceability** in your system.
It represents a **physical lot of agricultural produce** (e.g., 500 KG of rice harvested by a farmer).

ONDC uses this table (via the **inventory\_view**) to decide what products are available for discovery, catalog listing, and orders. Blockchain ensures trust and auditability.

---

## 🌱 **Why Batches are Needed**

* Farmers don’t just sell “products” → they sell **specific harvest lots**.
* Buyers (via ONDC) need to know:

  * How much stock is available
  * Where it was harvested
  * Whether it’s certified/organic
  * If it’s still fresh (expiry/harvest date)
* Regulators and consumers need to **verify provenance** (“farm-to-fork” traceability).

That’s why we **track every batch**, not just the product name.

---

## 🛠️ **Core Operations / Use Cases**

### 1️⃣ **Farmer Creates a New Batch (BatchCreated)**

* Action: After harvest, farmer (via BPP app) registers a new batch.
* Data stored:

  * `initial_qty_kg`, `unit` → harvested amount
  * `harvest_date` → when it was harvested
  * `geo_lat`, `geo_lon` → GPS location of farm
  * `meta_hash` → JSON/IPFS file with full details (photos, docs)
* Status: Starts as **`PENDING`**.

✅ Blockchain logs: `BatchCreated` event

---

### 2️⃣ **Update Batch Status**

* Possible flow:

  * `PENDING` → After farmer creates batch
  * `VERIFIED` → After inspector verifies details/certificates
  * `LISTED` → Once batch is available in ONDC catalog
  * `LOCKED` → When inventory is reserved for an order
  * `INVALIDATED` → If batch fails inspection or expires

✅ Blockchain logs: `BatchVerified`, `BatchListed`

---

### 3️⃣ **Split/Merge Batches**

* **Split**: If a farmer sells 200 KG of a 500 KG batch → a child batch is created (`parent_batch_id`).
* **Merge**: If multiple small batches are combined into one large lot → new batch is created, referencing parents.

This is critical in ONDC **order fulfillment**, where partial orders are common.

✅ Blockchain logs: `BatchSplit`, `BatchMerged`

---

### 4️⃣ **Update Harvest/Location Details**

* Farmers/logistics can update:

  * Storage location (e.g., warehouse name)
  * Updated GPS coordinates
  * Off-chain metadata (photos, transport documents) via `meta_hash`
* Ensures ONDC buyers know where the product is at every stage.

✅ Blockchain logs: `BatchUpdated`

---

### 5️⃣ **Anchor Metadata (meta\_hash)**

* Full batch details (photos, certifications, inspection docs) are stored **off-chain** in IPFS/S3.
* Only the **hash (meta\_hash)** is stored on blockchain.
* This ensures:

  * Transparency (anyone can verify hash)
  * Privacy (full docs aren’t exposed unless authorized)

✅ Blockchain logs: `BatchAnchored`

---

## 🔎 **ONDC Discovery Flow**

* ONDC doesn’t query raw `batches`.
* Instead, it queries the **`inventory_view`** (materialized view).
* The view joins:

  * `batches` (traceability + quantity)
  * `products` (catalog info)
  * `farmers` (producer info)
  * `product_batches` (price/expiry details)
* Only batches with:

  * `status = LISTED`
  * `current_qty_kg > 0`
    → appear in ONDC search results.

---

## 🧩 **Example Scenario**

1. Farmer Ajith harvests **500 KG of organic rice**.

   * Creates batch → `status = PENDING`.
2. Inspector uploads certificate → batch → `status = VERIFIED`.
3. BPP lists the batch on ONDC → `status = LISTED`.
4. Buyer places order for 200 KG → system **splits batch** (200 KG child + 300 KG remaining).
5. ONDC `search` query returns updated stock from **inventory\_view**.

---

✅ In short:

* **`batches` = backbone of traceability.**
* Farmers create, inspectors verify, buyers discover, blockchain secures.
* Directly powers ONDC **Discovery → Catalog → Order → Fulfillment**.

---

Do you want me to also make a **visual workflow diagram** (Farm → BatchCreated → Verified → Listed → Split → Order) so you can use it in docs/presentations?
