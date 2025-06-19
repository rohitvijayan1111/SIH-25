
# 📦 Backend Use Cases for BPP (Beckn Protocol Provider)

This document outlines how the **BPP (Beckn Protocol Provider)** backend interacts with the **Beckn network** APIs and internal systems. It details each use case, its purpose, backend logic, and the associated database tables.

---

## 🔍 1. Respond to Search (`/on_search`)

**📌 Goal**:
Respond to `/search` calls from a BAP (Buyer App Provider) with a list of available products and their pricing.

**✅ Backend Responsibilities**:

* Fetch products from `products` table.
* Fetch latest pricing from `price_list`.
* Ensure:

  * `stock > 0`
  * Current date is within `valid_from` and `valid_to`.
* Return products in a Beckn-compliant JSON format.

**🧩 Tables Involved**:

* `products`
* `price_list`

---

## 🛒 2. Respond to Selection (`/on_select`)

**📌 Goal**:
Confirm the availability and pricing of selected items before order placement.

**✅ Backend Responsibilities**:

* Validate each product’s availability using `products`.
* Verify pricing with the `price_list`.
* Optionally check historical inventory movements from `inventory_logs`.
* Send a fulfillment response including delivery info and product details.

**🧩 Tables Involved**:

* `products`
* `price_list`
* `inventory_logs` *(optional)*

---

## ✅ 3. Handle Order Confirmation (`/on_confirm`)

**📌 Goal**:
Confirm the order, deduct stock, and initiate the fulfillment process.

**✅ Backend Responsibilities**:

* Deduct ordered quantity from `products.stock`.
* Add a new entry to `fulfillments` to track the order.
* Record the stock reduction in `inventory_logs`.

**🧩 Tables Involved**:

* `products`
* `fulfillments`
* `inventory_logs`

---

## 🚚 4. Logistics Partner Discovery *(Internal Use or via Beckn Logistics)*

**📌 Goal**:
Identify the best available logistics provider for delivery.

**✅ Backend Responsibilities**:

* Search `logistics_providers` for available vehicles.
* Match based on:

  * Vehicle availability
  * Proximity to delivery location
  * Weight capacity

**🧩 Tables Involved**:

* `logistics_providers`

---

## 📦 5. Update Order Status (`/on_status`)

**📌 Goal**:
Provide real-time order status to the BAP.

**✅ Backend Responsibilities**:

* Retrieve the current `status` from `fulfillments`.
* Return `estimated_delivery` and current progress.

**🧩 Tables Involved**:

* `fulfillments`

---

## 📈 6. Track Inventory Changes *(Internal)*

**📌 Goal**:
Maintain a transparent history of stock movements.

**✅ Backend Responsibilities**:

* Record all stock changes in `inventory_logs`:

  * Sale → `OUT`
  * Restock → `IN`
  * Cancellation → `IN`

**🧩 Tables Involved**:

* `inventory_logs`
* `products`

---

## 🧾 7. Issue Final Bill (`/on_bill`)

**📌 Goal**:
Generate the final bill with product and delivery pricing.

**✅ Backend Responsibilities**:

* Multiply unit price (from `price_list`) with quantity.
* Add logistics/delivery charges if applicable.
* Return total amount in a bill payload.

**🧩 Tables Involved**:

* `price_list`
* `products`
* `fulfillments` *(for delivery info, if needed)*

---

## ✍️ 8. Accept and Store Ratings (`/on_rating`)

**📌 Goal**:
Capture post-order feedback and ratings from the buyer.

**✅ Backend Responsibilities**:

* Store `rating`, `review`, and associated `product_id` or `bpp_id` in `ratings`.

**🧩 Tables Involved**:

* `ratings`

---

## ❌ 9. Handle Cancellations (`/on_cancel`)

**📌 Goal**:
Handle a cancelled order by rolling back stock and fulfillment info.

**✅ Backend Responsibilities**:

* Update `fulfillments.status` to `'CANCELLED'`.
* Increase product stock back in `products.stock`.
* Record restock event in `inventory_logs` with `change_type = IN`.

**🧩 Tables Involved**:

* `fulfillments`
* `products`
* `inventory_logs`

---

## 📘 Summary Table

| Use Case             | API Endpoint  | Involved Tables                              |
| -------------------- | ------------- | -------------------------------------------- |
| Respond to Search    | `/on_search`  | `products`, `price_list`                     |
| Handle Selection     | `/on_select`  | `products`, `price_list`, `inventory_logs`   |
| Confirm Order        | `/on_confirm` | `fulfillments`, `inventory_logs`, `products` |
| Fulfillment Tracking | `/on_status`  | `fulfillments`                               |
| Logistics Matching   | Internal      | `logistics_providers`                        |
| Inventory Management | Internal      | `inventory_logs`, `products`                 |
| Accept Feedback      | `/on_rating`  | `ratings`                                    |
| Cancel Order         | `/on_cancel`  | `fulfillments`, `products`, `inventory_logs` |

---

