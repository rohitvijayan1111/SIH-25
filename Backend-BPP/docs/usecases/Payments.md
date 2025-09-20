Here’s a professional and **beginner-friendly API endpoint documentation** for your **`payments`** table, mapped to the ONDC Settlement & Payment flow. I’ve structured it so you can directly use it for development and testing.

---

# 🔹 **Payments API Endpoints**

**Use Case:** ONDC **Settlement & Payment** flow

* Lock payment when buyer places an order → `payment_status = INITIATED` / `LOCKED`
* Release funds upon delivery confirmation → `payment_status = RELEASED`
* Handle disputes / refunds → `payment_status = REFUNDED`
* Store payment proof receipts in IPFS → `proof_cid`
* ONDC integration → `on_settle` confirms blockchain settlement

---

## **1. Create Payment (Lock Payment)**

**POST** `/api/payments`

**Description:** Create a new payment record when the buyer places an order. Payment is initially `INITIATED`.

**Request Body (JSON):**

```json
{
  "order_id": "uuid-of-order",
  "batch_id": "uuid-of-batch",
  "payer": "buyer_name_or_id",
  "payee": "seller_name_or_id",
  "amount": 5000.00,
  "currency": "INR",
  "payment_method": "UPI",
  "payment_status": "INITIATED"  // optional, defaults to INITIATED
}
```

**Response (201 Created):**

```json
{
  "id": "uuid-of-payment",
  "order_id": "uuid-of-order",
  "batch_id": "uuid-of-batch",
  "payer": "buyer_name_or_id",
  "payee": "seller_name_or_id",
  "amount": 5000.00,
  "currency": "INR",
  "payment_method": "UPI",
  "payment_status": "INITIATED",
  "proof_cid": null,
  "chain_tx": null,
  "created_at": "2025-09-18T12:00:00Z"
}
```

---

## **2. Release Payment (Upon Delivery Confirmation)**

**PATCH** `/api/payments/:id/release`

**Description:** Mark a payment as `RELEASED` when the order is delivered. Optionally store the blockchain transaction hash.

**Request Body (JSON):**

```json
{
  "chain_tx": "0xabc123..."   // optional
}
```

**Response (200 OK):**

```json
{
  "id": "uuid-of-payment",
  "payment_status": "RELEASED",
  "chain_tx": "0xabc123..."
}
```

---

## **3. Refund Payment (Handle Disputes)**

**PATCH** `/api/payments/:id/refund`

**Description:** Mark a payment as `REFUNDED` in case of disputes or order cancellation.

**Request Body (JSON):**

```json
{
  "reason": "Buyer cancelled order",
  "chain_tx": "0xdef456..."  // optional
}
```

**Response (200 OK):**

```json
{
  "id": "uuid-of-payment",
  "payment_status": "REFUNDED",
  "chain_tx": "0xdef456..."
}
```

---

## **4. Upload Payment Proof (IPFS CID)**

**POST** `/api/payments/:id/proof`

**Description:** Store payment proof or receipt in IPFS.

**Request Body (JSON):**

```json
{
  "proof_cid": "QmXyz123..."
}
```

**Response (200 OK):**

```json
{
  "id": "uuid-of-payment",
  "proof_cid": "QmXyz123..."
}
```

---

## **5. Get Payment Details**

**GET** `/api/payments/:id`

**Description:** Retrieve the details of a specific payment.

**Response (200 OK):**

```json
{
  "id": "uuid-of-payment",
  "order_id": "uuid-of-order",
  "batch_id": "uuid-of-batch",
  "payer": "buyer_name_or_id",
  "payee": "seller_name_or_id",
  "amount": 5000.00,
  "currency": "INR",
  "payment_method": "UPI",
  "payment_status": "RELEASED",
  "proof_cid": "QmXyz123...",
  "chain_tx": "0xabc123...",
  "created_at": "2025-09-18T12:00:00Z"
}
```

---

## **6. List Payments (Optional Filters)**

**GET** `/api/payments`

**Query Parameters:**

* `status` → Filter by `INITIATED`, `LOCKED`, `RELEASED`, `REFUNDED`
* `order_id` → Filter by order
* `batch_id` → Filter by batch
* `payer` → Filter by payer
* `payee` → Filter by payee

**Response (200 OK):**

```json
[
  {
    "id": "uuid-of-payment",
    "order_id": "uuid-of-order",
    "batch_id": "uuid-of-batch",
    "payer": "buyer_name_or_id",
    "payee": "seller_name_or_id",
    "amount": 5000.00,
    "currency": "INR",
    "payment_method": "UPI",
    "payment_status": "RELEASED",
    "proof_cid": "QmXyz123...",
    "chain_tx": "0xabc123...",
    "created_at": "2025-09-18T12:00:00Z"
  }
]
```

---

### 🔹 **Notes**

1. Always validate `UUID` format for `order_id` and `batch_id`.
2. Payment `status` flow:

   ```
   INITIATED / LOCKED → RELEASED → REFUNDED
   ```
3. `proof_cid` stores IPFS proof; `chain_tx` stores blockchain transaction hash.
4. Optional: Add authentication/authorization to ensure only authorized actors can release or refund payments.

---

If you want, I can also **create a ready-to-use `restClient.http` file** for VS Code that tests all these payment endpoints with sample requests and responses.

Do you want me to do that next?
