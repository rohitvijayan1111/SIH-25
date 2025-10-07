Sure! For your `middlemen_purchase` table, here’s a detailed list of **endpoint use cases** you can implement for the **BAP (client) side**. I’ve organized them by CRUD operations, status updates, and blockchain/payment interactions.

---

## 1️⃣ **Create / Add Purchase**

**Endpoint:** `POST /middlemen/purchases`
**Purpose:** Record a new purchase when a middleman buys a batch from a farmer.

**Request Body Example:**

```json
{
  "purchase_code": "PUR-2025-00067",
  "middleman_id": "uuid-of-middleman",
  "farmer_id": "uuid-of-farmer",
  "batch_id": "uuid-of-batch",
  "product_id": "uuid-of-product",
  "quantity_kg": 500,
  "price_per_kg": 42.00,
  "currency": "INR",
  "payment_mode": "UPI"
}
```

**Response Example:**

```json
{
  "status": "success",
  "data": {
    "purchase_id": "generated-uuid",
    "total_price": 21000.00,
    "payment_status": "PENDING",
    "delivery_status": "PENDING"
  }
}
```

**Use Case:** Record transactions, calculate total price automatically, and prepare for blockchain anchoring.

---

## 2️⃣ **Get Purchase Details**

**Endpoint:** `GET /middlemen/purchases/{purchase_id}`
**Purpose:** Fetch full details of a purchase for middleman, farmer, or admin dashboards.

**Response Example:**

```json
{
  "purchase_id": "uuid",
  "purchase_code": "PUR-2025-00067",
  "middleman_id": "uuid",
  "farmer_id": "uuid",
  "batch_id": "uuid",
  "product_id": "uuid",
  "quantity_kg": 500,
  "price_per_kg": 42.00,
  "total_price": 21000.00,
  "currency": "INR",
  "payment_status": "PAID",
  "delivery_status": "DELIVERED",
  "payment_mode": "UPI",
  "chain_tx": "0x7abcf9d8a...",
  "proof_cid": "QmTx37yHn...",
  "purchase_date": "2025-10-06T12:45:00",
  "updated_at": "2025-10-06T13:00:00"
}
```

**Use Case:** Display purchase details to middleman or farmer; also used in blockchain verification.

---

## 3️⃣ **List Purchases**

**Endpoint:** `GET /middlemen/purchases?middleman_id={id}&status={status}`
**Purpose:** Get a list of purchases for a middleman, filtered by payment/delivery status.

**Query Parameters:**

* `middleman_id` (optional)
* `farmer_id` (optional)
* `payment_status` (optional)
* `delivery_status` (optional)

**Response Example:**

```json
{
  "purchases": [
    {
      "purchase_id": "uuid1",
      "purchase_code": "PUR-2025-00067",
      "total_price": 21000.00,
      "payment_status": "PAID",
      "delivery_status": "DELIVERED"
    },
    {
      "purchase_id": "uuid2",
      "purchase_code": "PUR-2025-00068",
      "total_price": 15750.00,
      "payment_status": "PENDING",
      "delivery_status": "SHIPPED"
    }
  ]
}
```

**Use Case:** Dashboard for middlemen or admin to track all purchases and statuses.

---

## 4️⃣ **Update Payment Status**

**Endpoint:** `PATCH /middlemen/purchases/{purchase_id}/payment`
**Purpose:** Update the payment status after successful payment or failure.

**Request Body Example:**

```json
{
  "payment_status": "PAID",
  "chain_tx": "0xabcdef1234...",
  "proof_cid": "QmInvoiceProof..."
}
```

**Use Case:** Integrates with payment gateway / blockchain. Automatically marks payment as confirmed.

---

## 5️⃣ **Update Delivery Status**

**Endpoint:** `PATCH /middlemen/purchases/{purchase_id}/delivery`
**Purpose:** Update delivery tracking: `PENDING → SHIPPED → DELIVERED`.

**Request Body Example:**

```json
{
  "delivery_status": "DELIVERED"
}
```

**Use Case:** Syncs warehouse/logistics info and lets the buyer and farmer see delivery updates.

---

## 6️⃣ **Fetch Blockchain & Proof Details**

**Endpoint:** `GET /middlemen/purchases/{purchase_id}/proof`
**Purpose:** Retrieve blockchain transaction hash and IPFS invoice proof for verification.

**Response Example:**

```json
{
  "purchase_id": "uuid",
  "chain_tx": "0x7abcf9d8a76e...",
  "proof_cid": "QmTx37yHn..."
}
```

**Use Case:** Audit or dispute resolution, shows immutable proof of purchase.

---

## 7️⃣ **Delete / Cancel Purchase**

**Endpoint:** `DELETE /middlemen/purchases/{purchase_id}`
**Purpose:** Cancel a pending purchase (only if `payment_status = PENDING`).

**Use Case:** Allows middlemen to cancel before payment or farmer to reject a purchase.
*(Should be controlled via business rules, possibly creating a `cancellation_reason` log.)*

---

## 8️⃣ **Analytics / Reports Endpoint**

**Endpoint:** `GET /middlemen/purchases/report?middleman_id={id}&from={date}&to={date}`

**Response Example:**

```json
{
  "total_purchases": 12,
  "total_quantity": 4500,
  "total_spent": 189000.00,
  "pending_payments": 2,
  "delivered_batches": 10
}
```

**Use Case:** For middlemen to track spend, quantity purchased, pending deliveries, and generate invoices.

---

✅ **Summary: How It Maps to Your Table**

| Table Feature                                               | Endpoint / Use Case                                          |
| ----------------------------------------------------------- | ------------------------------------------------------------ |
| Basic details (purchase_code, middleman_id, batch_id, etc.) | `POST /middlemen/purchases`, `GET /middlemen/purchases/{id}` |
| Quantity & Price                                            | Auto-calculated `total_price`, used in listing & reports     |
| Payment & Delivery Status                                   | `PATCH /middlemen/purchases/{id}/payment`, `PATCH /delivery` |
| Blockchain / Proof                                          | `GET /proof`, `PATCH /payment` with chain_tx                 |
| Analytics                                                   | `GET /report`                                                |
| Deletion / Cancel                                           | `DELETE /middlemen/purchases/{id}`                           |

---

If you want, I can **draw a complete BAP endpoint flow diagram** showing **how middleman interacts with farmer, batches, payment, and blockchain**, which makes it easy to implement APIs and frontend dashboards.

Do you want me to do that?
