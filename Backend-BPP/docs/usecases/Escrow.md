Perfect 👍 — let’s write detailed **API endpoint documentation** for

## 🔹 **16. Escrows**

This will follow the **same style as your Payments module**, but focused on escrow lifecycle (Lock → Release → Refund → Query).

---

# 📖 Escrow API Documentation

### 📌 Base URL

```
/api/escrows
```

---

## 1️⃣ Create & Lock Escrow

👉 Lock buyer’s money into escrow (at order placement).

**Endpoint**

```http
POST /api/escrows
```

**Request Body**

```json
{
  "escrow_ref": "ESCROW12345",
  "order_id": "11111111-1111-1111-1111-111111111111",
  "amount": 500.00
}
```

**Behavior**

* Creates escrow row linked to `order_id`.
* Marks `locked = TRUE`, `locked_at = now()`.
* Funds are now held safely until delivery.

**Response**

```json
{
  "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
  "escrow_ref": "ESCROW12345",
  "order_id": "11111111-1111-1111-1111-111111111111",
  "amount": "500.00",
  "locked": true,
  "released": false,
  "locked_at": "2025-09-19T10:15:30.123Z"
}
```

---

## 2️⃣ Release Escrow

👉 Release escrow to seller (ONDC `on_confirm` or delivery success).

**Endpoint**

```http
PUT /api/escrows/:id/release
```

**Request Body**

```json
{
  "chain_tx": "0xblockchainReleaseTxHash"
}
```

**Behavior**

* Updates escrow: `released = TRUE`, `released_at = now()`.
* Records blockchain proof via `chain_tx`.

**Response**

```json
{
  "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
  "escrow_ref": "ESCROW12345",
  "released": true,
  "released_at": "2025-09-19T12:00:00.456Z",
  "chain_tx": "0xblockchainReleaseTxHash"
}
```

---

## 3️⃣ Refund Escrow

👉 Refund buyer if order is cancelled/disputed (`on_cancel`).

**Endpoint**

```http
PUT /api/escrows/:id/refund
```

**Request Body**

```json
{
  "chain_tx": "0xblockchainRefundTxHash",
  "reason": "Order cancelled by buyer"
}
```

**Behavior**

* Keeps `released = FALSE`.
* Adds blockchain `chain_tx` proof of refund.
* Returns refund details for traceability.

**Response**

```json
{
  "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
  "escrow_ref": "ESCROW12345",
  "released": false,
  "refunded": true,
  "reason": "Order cancelled by buyer",
  "chain_tx": "0xblockchainRefundTxHash"
}
```

---

## 4️⃣ Upload Blockchain Proof

👉 Attach / update blockchain transaction reference separately.

**Endpoint**

```http
PUT /api/escrows/:id/proof
```

**Request Body**

```json
{
  "chain_tx": "0xproofTxHash"
}
```

**Response**

```json
{
  "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
  "escrow_ref": "ESCROW12345",
  "chain_tx": "0xproofTxHash"
}
```

---

## 5️⃣ Get Escrow by ID

👉 Retrieve a single escrow record.

**Endpoint**

```http
GET /api/escrows/:id
```

**Response**

```json
{
  "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
  "escrow_ref": "ESCROW12345",
  "order_id": "11111111-1111-1111-1111-111111111111",
  "amount": "500.00",
  "locked": true,
  "released": false,
  "locked_at": "2025-09-19T10:15:30.123Z"
}
```

---

## 6️⃣ List Escrows (with filters)

👉 Useful for admin dashboards & dispute management.

**Endpoint**

```http
GET /api/escrows?status=locked&order_id=11111111-1111-1111-1111-111111111111
```

**Supported Filters**

* `status = locked|released`
* `order_id = UUID`
* `escrow_ref = string`

**Response**

```json
[
  {
    "id": "bfc0f1a1-5678-43a9-9d22-59b1fa123456",
    "escrow_ref": "ESCROW12345",
    "order_id": "11111111-1111-1111-1111-111111111111",
    "amount": "500.00",
    "locked": true,
    "released": false,
    "locked_at": "2025-09-19T10:15:30.123Z"
  }
]
```

---

## 🔗 ONDC Use Cases

* **`on_confirm`** → trigger `/release`
* **`on_cancel`** → trigger `/refund`
* **Dispute management** → query via `/list` & `/proof`

---

Do you want me to also **write the Node.js controller + routes** for these endpoints (like we did for Payments), so you can plug them directly into your backend?
