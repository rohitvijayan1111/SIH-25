Here’s a detailed list of **backend use cases** for your `orders` and `order_items` tables in `bap_agri_db`:

---

## **1️⃣ Orders Table Use Cases**

| Use Case                        | Description                                                                       | Columns Involved                                                                                                  |
| ------------------------------- | --------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| **Create a new order**          | When a user places an order, insert a new row with status `INITIATED`.            | `id`, `user_id`, `bpp_id` (nullable now), `farmer_id`, `status`, `total_amount`, `delivery_address`, `created_at` |
| **Update order status**         | Track the lifecycle of an order: `INITIATED → CONFIRMED → FULFILLED → CANCELLED`. | `status`, `updated_at`                                                                                            |
| **Assign fulfillment/dispatch** | Link an order to a fulfillment ID when logistics team picks it.                   | `fulfillment_id`, `status`                                                                                        |
| **Calculate total amount**      | Backend computes total by summing `unit_price * quantity` from `order_items`.     | `total_amount`                                                                                                    |
| **Fetch user orders**           | API endpoint to get all orders for a user.                                        | `user_id`, `status`, `created_at`                                                                                 |
| **Fetch farmer orders**         | For a farmer dashboard to see orders assigned to them.                            | `farmer_id`, `status`                                                                                             |
| **Cancel order**                | Update status to `CANCELLED` if order is cancelled before fulfillment.            | `status`                                                                                                          |
| **Link to payment**             | After payment, associate payment transaction record.                              | `id` (order_id)                                                                                                   |

---

## **2️⃣ Order_Items Table Use Cases**

| Use Case                          | Description                                                       | Columns Involved                                                                      |
| --------------------------------- | ----------------------------------------------------------------- | ------------------------------------------------------------------------------------- |
| **Add items to an order**         | When an order is created, insert multiple items.                  | `id`, `order_id`, `bpp_product_id`, `item_name`, `quantity`, `unit_price`, `batch_id` |
| **Update item quantity or price** | Backend can adjust quantity or price before order confirmation.   | `quantity`, `unit_price`                                                              |
| **Assign batch**                  | Link each item to a specific batch from inventory.                | `batch_id`                                                                            |
| **Calculate order total**         | Sum all `quantity * unit_price` per order.                        | `quantity`, `unit_price`, `order_id`                                                  |
| **Fetch items for an order**      | API to display all items in a given order.                        | `order_id`, `item_name`, `quantity`, `unit_price`, `batch_id`                         |
| **Track stock deduction**         | When an order is fulfilled, reduce inventory based on `batch_id`. | `batch_id`, `quantity`                                                                |

---

## **3️⃣ Typical Backend Flow**

1. **User places an order** → create row in `orders` (status `INITIATED`)
2. **Add items** → insert multiple rows in `order_items` with `order_id`
3. **Compute total** → update `orders.total_amount`
4. **Confirm order** → update `orders.status` to `CONFIRMED`
5. **Assign batches & fulfillment** → update `order_items.batch_id` and `orders.fulfillment_id`
6. **Track delivery** → update `orders.status` to `FULFILLED` or `CANCELLED`
7. **Payment & ratings** → link `payment_transactions` and `ratings` table

---

This structure ensures **order management, inventory tracking, and payment processing** are all consistent.

---

If you want, I can **draw a diagram showing the relationship between `orders`, `order_items`, and related tables** for backend workflows — it helps in designing APIs clearly.

Do you want me to do that?
