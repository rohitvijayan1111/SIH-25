
---

# 📦 Backend Use Cases for BPP (Beckn Protocol Provider)

This document outlines how the **BPP (Beckn Protocol Provider)** backend interacts with the **Beckn network** APIs and internal systems. It details each use case, its purpose, backend logic, and the associated database tables.

---

## 🔍 1. Respond to Search (`/on_search`)

**📌 Goal**:
Respond to `/search` calls from a BAP (Buyer App Provider) with a list of available products and their pricing.

**✅ Backend Responsibilities**:

* Fetch products from `products` table.
* Fetch latest valid pricing from `price_list` where current date is between `valid_from` and `valid_to`.
* Include metadata from:

  * `farmers` (provider info),
  * `locations` (location\_id and address),
  * `catalog_fulfillments` (fulfillment info).
* Ensure stock is greater than 0.
* Return products in a Beckn-compliant JSON format.

**🧩 Tables Involved**:

* `products`
* `price_list`
* `farmers`
* `locations`
* `catalog_fulfillments`

---

## 🛒 2. Respond to Selection (`/on_select`)

**📌 Goal**:
Confirm availability and pricing of selected items before order placement.

**✅ Backend Responsibilities**:

* Validate product availability (`products.stock`).
* Verify price validity (`price_list`).
* Optionally check historical inventory changes (`inventory_logs`).
* Provide fulfillment details from `catalog_fulfillments`.

**🧩 Tables Involved**:

* `products`
* `price_list`
* `inventory_logs` *(optional)*
* `catalog_fulfillments`

---
Absolutely! Here's a **short and great version** of the **`/on_init` use case** along with the **tables used** on the **BPP side**:

---

## 2.5 ✅ `/on_init` Use Case (BPP Side)

### 🔹 Purpose:

Lock final **price, items, stock, and delivery info** before BAP collects payment.

---

### 🔁 When It Happens:

After `/init` from BAP → BPP responds with `/on_init`.

---

### 📦 What BPP Includes in `/on_init`:

| Field         | Description                       |
| ------------- | --------------------------------- |
| `items[]`     | Product IDs, quantity, unit price |
| `quote`       | Final total + item-wise breakup   |
| `fulfillment` | Delivery/pickup info + ETA        |
| `payment`     | Type, status = `NOT-PAID`, TTL    |

---

### 🧠 Real World Analogy:

> Like freezing your cart price and stock before paying on Amazon.

---

### 🗃️ BPP Tables Used:

| Table                  | Used For                                 |
| ---------------------- | ---------------------------------------- |
| `products`             | Get current stock and product info       |
| `price_list`           | Fetch latest valid price per unit        |
| `catalog_fulfillments` | Provide delivery/pickup address and ETA  |
| `inventory_logs` (opt) | Log/validate historical stock (optional) |

---

### ✅ After `/on_init`:

1. BAP **shows quote to user**
2. BAP **collects payment**
3. BAP sends `/confirm` with `transaction_id`

---

Let me know if you want this as a PDF or diagram!



## ✅ 3. Handle Order Confirmation (`/on_confirm`)

**📌 Goal**:
Confirm order, deduct stock, and initiate fulfillment tracking.

**✅ Backend Responsibilities**:

* Deduct ordered quantity from `products.stock`.
* Insert a new row in `order_fulfillments` to track order status and link to `products` and `farmers`.
* Record stock deduction in `inventory_logs`.

**🧩 Tables Involved**:

* `products`
* `order_fulfillments`
* `inventory_logs`

---

## 🚚 4. Logistics Partner Discovery *(Internal Use or via Beckn Logistics)*

**📌 Goal**:
Identify the best available logistics provider for delivery.

**✅ Backend Responsibilities**:

* Query `logistics_providers` for available providers.
* Filter based on availability, capacity, proximity, and vehicle type.

**🧩 Tables Involved**:

* `logistics_providers`

---

## 📦 5. Update Order Status (`/on_status`)

**📌 Goal**:
Provide real-time order status updates to BAP.

**✅ Backend Responsibilities**:

* Retrieve current `status` and `estimated_delivery` from `order_fulfillments`.
* Return status and progress info to caller.

**🧩 Tables Involved**:

* `order_fulfillments`

---

## 📈 6. Track Inventory Changes *(Internal)*

**📌 Goal**:
Maintain history of stock movements for audit and inventory management.

**✅ Backend Responsibilities**:

* Log all stock changes (`IN` or `OUT`) in `inventory_logs`.
* Changes triggered by sales, restocks, or cancellations.

**🧩 Tables Involved**:

* `inventory_logs`
* `products`

---

## 🧾 7. Issue Final Bill (`/on_bill`)

**📌 Goal**:
Generate the final bill including product prices and delivery charges.

**✅ Backend Responsibilities**:

* Calculate total product price (unit price × quantity) using `price_list`.
* Add logistics/delivery fees if applicable.
* Provide full billing details.

**🧩 Tables Involved**:

* `price_list`
* `products`
* `order_fulfillments` *(for delivery info)*

---

## ✍️ 8. Accept and Store Ratings (`/on_rating`)

**📌 Goal**:
Capture feedback and ratings post-delivery.

**✅ Backend Responsibilities**:

* Store ratings, reviews, user IDs, and product or BPP IDs in `ratings`.

**🧩 Tables Involved**:

* `ratings`

---

## ❌ 9. Handle Cancellations (`/on_cancel`)

**📌 Goal**:
Process order cancellations, revert stock, and update fulfillment status.

**✅ Backend Responsibilities**:

* Update `order_fulfillments.status` to `'CANCELLED'`.
* Revert stock in `products.stock`.
* Log stock revert in `inventory_logs` (`change_type = 'IN'`).

**🧩 Tables Involved**:

* `order_fulfillments`
* `products`
* `inventory_logs`

---

## 📘 Summary Table

| Use Case             | API Endpoint  | Involved Tables                                                          |
| -------------------- | ------------- | ------------------------------------------------------------------------ |
| Respond to Search    | `/on_search`  | `products`, `price_list`, `farmers`, `locations`, `catalog_fulfillments` |
| Handle Selection     | `/on_select`  | `products`, `price_list`, `inventory_logs`, `catalog_fulfillments`       |
| Confirm Order        | `/on_confirm` | `products`, `order_fulfillments`, `inventory_logs`                       |
| Fulfillment Tracking | `/on_status`  | `order_fulfillments`                                                     |
| Logistics Matching   | Internal      | `logistics_providers`                                                    |
| Inventory Management | Internal      | `inventory_logs`, `products`                                             |
| Accept Feedback      | `/on_rating`  | `ratings`                                                                |
| Cancel Order         | `/on_cancel`  | `order_fulfillments`, `products`, `inventory_logs`                       |

---

If you want, I can also help with example **API request/response payloads**, or the **Node.js service/controller code** implementing these use cases!
