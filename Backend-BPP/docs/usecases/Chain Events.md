Perfect! Let’s fully detail **all endpoints for the `chain_events` table** using your latest schema. I’ll include **purpose, routes, parameters, request/response examples, and use cases** for your documentation.

---

# 🔹 **14. Chain Events**

**Table Schema:**

```sql
CREATE TABLE chain_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    event_type VARCHAR(50),      -- e.g., BatchCreated, TransferRecorded, PaymentReleased
    entity_type VARCHAR(50),     -- type of entity: batch, order, payment
    entity_id UUID,              -- ID of the entity this event relates to
    details JSONB,               -- extra event-specific info
    tx_hash TEXT,                -- blockchain transaction hash
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

**Purpose:**
Acts as a **global audit & eventing layer** for ONDC. Records all key supply chain and payment events to enable:

* Transparent audit logs for buyers/sellers.
* Immutable tracking for trust dashboards.
* Blockchain verification via `tx_hash`.

---

## **Endpoints**

### 1️⃣ Record a New Chain Event

**Endpoint:**

```
POST /api/chain-events
```

**Purpose:**
Record any key supply chain or payment event.

**Request Body Example:**

```json
{
  "event_type": "TransferRecorded",
  "entity_type": "batch",
  "entity_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
  "details": {
    "from_actor": "Farmer Ajith",
    "to_actor": "FPO-07",
    "quantity_kg": 120,
    "location_name": "Village Collection Center"
  },
  "tx_hash": "0xabc123..."
}
```

**Use Cases:**

* Track farmer → FPO → logistics → retailer events.
* Record payments or order creations for audit.

---

### 2️⃣ Fetch All Chain Events

**Endpoint:**

```
GET /api/chain-events
```

**Purpose:**
Retrieve **all recorded events**.

**Response Example:**

```json
[
  {
    "id": "e1a2b3d4-5678-90ab-cdef-1234567890ab",
    "event_type": "BatchCreated",
    "entity_type": "batch",
    "entity_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
    "details": { "batch_name": "Wheat-2025" },
    "tx_hash": "0xaaa111...",
    "created_at": "2025-09-18T10:00:00Z"
  }
]
```

**Use Cases:**

* Build global audit dashboards.
* Feed ONDC trust dashboard for buyers/sellers.

---

### 3️⃣ Fetch Events by Entity

**Endpoint:**

```
GET /api/chain-events/entity/:entity_type/:entity_id
```

**Purpose:**
Fetch all events for a **specific batch/order/payment**.

**Response Example:**

```json
[
  {
    "event_type": "TransferRecorded",
    "entity_type": "batch",
    "entity_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
    "details": { "quantity_kg": 120, "to_actor": "FPO-07" },
    "tx_hash": "0xabc123...",
    "created_at": "2025-09-18T10:30:00Z"
  }
]
```

**Use Cases:**

* Show farm-to-fork journey for a batch.
* Buyer auditing product authenticity.
* Regulators validating compliance.

---

### 4️⃣ Fetch Events by Actor

**Endpoint:**

```
GET /api/chain-events/actor/:actor_name
```

**Purpose:**
Fetch **all events involving a specific actor**.

**Response Example:**

```json
[
  {
    "event_type": "TransferRecorded",
    "entity_type": "batch",
    "entity_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
    "details": { "from_actor": "Farmer Ajith", "to_actor": "FPO-07" },
    "tx_hash": "0xabc123...",
    "created_at": "2025-09-18T10:30:00Z"
  }
]
```

**Use Cases:**

* Actor-specific dashboards (FPO, retailer, logistics).
* Reconciliation of transactions by actor.

---

### 5️⃣ Fetch Latest Event for an Entity

**Endpoint:**

```
GET /api/chain-events/latest/:entity_type/:entity_id
```

**Purpose:**
Retrieve **most recent event** for an entity.

**Response Example:**

```json
{
  "event_type": "TransferRecorded",
  "entity_type": "batch",
  "entity_id": "b23eaa50-6a2f-4c27-9f4f-12e4a8c33d9f",
  "details": { "quantity_kg": 120 },
  "tx_hash": "0xabc123...",
  "created_at": "2025-09-18T10:30:00Z"
}
```

**Use Cases:**

* Real-time tracking for buyer apps.
* Know **current status of a batch/order/payment**.

---

### 6️⃣ Verify Event on Blockchain

**Endpoint:**

```
GET /api/chain-events/:id/verify
```

**Purpose:**
Verify if an event exists on-chain via `tx_hash`.

**Response Example:**

```json
{
  "event_id": "e1a2b3d4-5678-90ab-cdef-1234567890ab",
  "verified": true,
  "tx_hash": "0xabc123...",
  "note": "Event exists on blockchain"
}
```

**Use Cases:**

* Buyers validate authenticity of transfers/payments.
* Certification bodies ensure supply chain integrity.

---

### 7️⃣ Update Event (Optional / Pre-Blockchain)

**Endpoint:**

```
PUT /api/chain-events/:id
```

**Purpose:**
Update details **before blockchain confirmation**.

**Request Body Example:**

```json
{
  "details": { "quantity_kg": 125 }
}
```

**Use Cases:**

* Correct errors before final blockchain commit.

---

### 8️⃣ Delete Event (Soft Delete / Pre-Blockchain)

**Endpoint:**

```
DELETE /api/chain-events/:id
```

**Purpose:**
Soft-delete event records **before blockchain commit**.

**Use Cases:**

* Remove test or erroneous events.

---

This setup makes **Chain Events** a **complete immutable audit layer** for ONDC with:

* **Full entity & actor traceability**
* **Real-time tracking**
* **Blockchain verification**

---

If you want, I can **write the full CommonJS controllers + Express routes + REST Client `.http` file** for this `chain_events` module exactly like we did for **Transfers**.

Do you want me to do that next?
