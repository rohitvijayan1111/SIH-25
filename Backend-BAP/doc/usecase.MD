Thanks for sharing your well-structured `bap_agri_db` schema. Based on this schema, here's the **corrected and mapped set of BAP (Beckn API Platform – Consumer Side) backend use cases**, aligned with your actual tables, including field-level alignment and data flow.

---

# ✅ 📲 BAP Use Cases – Aligned to `bap_agri_db`

---

## 🔍 1. Initiate Search (`/search` → `/on_search`)

### 📌 Goal:

User searches for products or services (e.g., agri inputs). BAP sends `/search`, stores input, and processes `/on_search`.

### ✅ Backend Flow:

* Collect search query and optional filters (category).
* Save in `search_requests`.
* Generate a transaction ID and send `/search` to the Beckn network.
* Process `/on_search` responses from BPP(s), store or cache them if needed (optional table not included in current schema).

### 🗃️ Involved Table:

* `search_requests`

---

## 🛒 2. Item Selection (`/select` → `/on_select`)

### 📌 Goal:

User selects item(s) from BPP. Confirm availability, price, and store selection.

### ✅ Backend Flow:

* Send `/select` with selected item IDs and BPP reference.
* Await `/on_select` for validation.
* Temporarily save this in session or frontend; DB persistence is optional (you can use a `cart` table if needed).

### 🗃️ Tables:

* No DB persistence required as per current schema.
* Could extend `orders` with a "draft" status if needed.

---

## 📝 3. Order Initialization (`/init` → `/on_init`)

### 📌 Goal:

Send user’s address, logistics preferences, and payment mode. Lock price and fulfillment details.

### ✅ Backend Flow:

* Create a new entry in `orders` (status = `INITIATED`).
* Add `order_items` for each item in the cart.
* Insert into `logistics_preferences` based on pickup/drop info.
* Store BPP response from `/on_init` for rendering quote.

### 🗃️ Tables:

* `orders`
* `order_items`
* `logistics_preferences`

---

## ✅ 4. Confirm Order (`/confirm` → `/on_confirm`)

### 📌 Goal:

Confirm order placement after payment initiation.

### ✅ Backend Flow:

* Send `/confirm` request with transaction reference.
* Update `orders.status` to `CONFIRMED`.
* Insert into `payment_transactions` with status `PENDING`.
* After `/on_confirm`, proceed with fulfillment tracking.

### 🗃️ Tables:

* `orders`
* `payment_transactions`

---

## 🚚 5. Track Order Status (`/status` → `/on_status`)

### 📌 Goal:

Fetch and display fulfillment progress.

### ✅ Backend Flow:

* Send `/status` with order reference.
* On receiving `/on_status`, update `order_tracking`.

### 🗃️ Tables:

* `order_tracking`

---

## 🧾 6. Final Bill (`/bill` → `/on_bill`)

### 📌 Goal:

Show itemized invoice + logistics charges to the user.

### ✅ Backend Flow:

* Receive `/on_bill` from BPP.
* Update `orders.total_amount`.
* Optionally store `invoice_url` or itemized breakdown (add-on schema required if needed).

### 🗃️ Tables:

* `orders`
* `order_items` (already contains unit price and quantity)

---

## ✍️ 7. Ratings (`/rating` → `/on_rating`)

### 📌 Goal:

Collect post-fulfillment feedback from users.

### ✅ Backend Flow:

* User gives rating on BPP/order.
* Send `/rating`.
* On `/on_rating`, store feedback.

### 🗃️ Tables:

* `ratings`

---

## ❌ 8. Cancel Order (`/cancel` → `/on_cancel`)

### 📌 Goal:

Allow users to cancel active orders before dispatch.

### ✅ Backend Flow:

* Send `/cancel` to BPP.
* On `/on_cancel`, update `orders.status = CANCELLED`.
* Log event in `order_tracking`.

### 🗃️ Tables:

* `orders`
* `order_tracking`

---

## 🔔 9. Notifications (Internal Use)

### 📌 Goal:

Send messages for order status, payments, system alerts.

### ✅ Backend Flow:

* Generate entry in `notifications` per user action/event.
* Update `status` based on delivery attempts.

### 🗃️ Table:

* `notifications`

🔁 When This Happens:
After receiving /on_search and /on_select from BPP

Before calling /init to finalize order

🎯 Why Needed:
The BAP must temporarily store selected items, especially in multi-item or multi-BPP flows, before constructing the final /init payload.


✅ Use Case Name: Add to Cart (Pre-Init Phase)
📌 Goal:
Allow users to select products and quantities before placing an order, similar to an e-commerce cart.





---

## 📘 Summary Mapping

| BAP Use Case         | API Flow                 | Tables Used                                      |
| -------------------- | ------------------------ | ------------------------------------------------ |
| Initiate Search      | `/search`                | `search_requests`                                |
| Item Selection       | `/select`                | *(none yet, can use temp store or extend)*       |
| Order Init           | `/init` → `/on_init`     | `orders`, `order_items`, `logistics_preferences` |
| Confirm Order        | `/confirm`               | `orders`, `payment_transactions`                 |
| Track Fulfillment    | `/status` → `/on_status` | `order_tracking`                                 |
| Final Bill           | `/bill` → `/on_bill`     | `orders`, `order_items`                          |
| Submit Rating        | `/rating` → `/on_rating` | `ratings`                                        |
| Cancel Order         | `/cancel` → `/on_cancel` | `orders`, `order_tracking`                       |
| System Notifications | Internal                 | `notifications`                                  |

---

Would you like the following next?

* Sample JSON payloads for any API
* Backend controller structure in Node.js (Express)
* Visual flowcharts of use cases

Let me know how deep you want to go 🚀
