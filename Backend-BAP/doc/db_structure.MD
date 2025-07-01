Great! You're almost there. Below is your **fixed and fully aligned BAP schema** (`bap_agri_db`) — now updated to:

* ✅ Use `UUID` across all tables (for compatibility with BPP using UUIDs)
* ✅ Match foreign keys with BPP schema (`product_id`, `bpp_id`, etc.)
* ✅ Add `bpp_product_id`, `farmer_id`, and `fulfillment_id` where needed
* ✅ Improve constraints, naming consistency, timestamps
* ✅ Fully ONDC-compatible

---

## ✅ **Fixed SQL Schema for BAP (Consumer Side)** – `bap_agri_db`

> 🔐 Uses `UUID` (via `gen_random_uuid()` from `pgcrypto`)

---

### 🔹 STEP 1: Create Database and Enable UUIDs

```sql
CREATE DATABASE bap_agri_db;
\c bap_agri_db
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```

---

### 🧱 Full Updated Schema (with UUIDs)

```sql
-- 1. Users Table
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE,
    role VARCHAR(20) CHECK (role IN ('farmer','buyer','logistics','admin')) NOT NULL,
    kyc_id VARCHAR(50),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Search Requests
CREATE TABLE search_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    query TEXT NOT NULL,
    category VARCHAR(50),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    transaction_id UUID,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- 3. Orders Table
CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    bpp_id VARCHAR(100) NOT NULL,
    farmer_id UUID NOT NULL,
    fulfillment_id VARCHAR(100), -- from BPP.catalog_fulfillments.fulfillment_code
    status VARCHAR(20) DEFAULT 'INITIATED' CHECK (status IN ('INITIATED','CONFIRMED','FULFILLED','CANCELLED')),
    total_amount DECIMAL(10,2) NOT NULL,
    delivery_address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 4. Order Items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL,
    bpp_product_id UUID NOT NULL,
    item_name TEXT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- 5. Logistics Preferences
CREATE TABLE logistics_preferences (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL,
    preferred_mode VARCHAR(50),
    pickup_location TEXT,
    drop_location TEXT,
    scheduled_time TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- 6. Payment Transactions
CREATE TABLE payment_transactions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL,
    method VARCHAR(20),
    amount DECIMAL(10,2) NOT NULL,
    payment_status VARCHAR(20) DEFAULT 'PENDING' CHECK (payment_status IN ('PENDING','SUCCESS','FAILED')),
    transaction_ref VARCHAR(100),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- 7. Order Tracking
CREATE TABLE order_tracking (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID NOT NULL,
    current_status VARCHAR(100),
    remarks TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
);

-- 8. Ratings
CREATE TABLE ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    order_id UUID NOT NULL,
    bpp_id VARCHAR(100),
    product_id UUID,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    feedback TEXT,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- 9. Notifications
CREATE TABLE notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    message TEXT,
    type VARCHAR(20) DEFAULT 'ORDER' CHECK (type IN ('ORDER','PAYMENT','PROMOTION','SYSTEM')),
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('SENT','PENDING','FAILED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 10. User Cart (Pre-/on_select Phase)
CREATE TABLE user_cart (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    bpp_id VARCHAR(100) NOT NULL,
    bpp_product_id UUID NOT NULL,
    item_name TEXT,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(10,2) NOT NULL,
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
```

---

## ✅ Aligned with BPP Schema

| Concept        | BAP Table/Column                               | BPP Source                              |
| -------------- | ---------------------------------------------- | --------------------------------------- |
| Product ID     | `bpp_product_id` in `order_items`, `user_cart` | `products.id` in BPP                    |
| Farmer ID      | `farmer_id` in `orders`                        | `farmers.id` in BPP                     |
| Fulfillment ID | `fulfillment_id` in `orders`                   | `catalog_fulfillments.fulfillment_code` |
| BPP ID         | `bpp_id` in `orders`, `ratings`, etc.          | BPP platform identifier                 |

---

## 📦 Optional Improvements You Can Add Later

| Feature                    | Table/Column Suggestion                         |
| -------------------------- | ----------------------------------------------- |
| Cart Expiry                | Add `expires_at` to `user_cart`                 |
| Promotions or Discounts    | Add `discount_amount` to `order_items`          |
| Invoice/Billing snapshot   | Create a `bills` table to store `/on_bill` JSON |
| Consent or user token logs | Add a `consents` or `auth_logs` table           |

---

Would you like:

* ✅ Sequelize/Prisma Models for this schema?
* ✅ Example JSON payloads for `/init`, `/confirm`, `/status`?
* ✅ ER diagram (PDF/Image) of this database?

Let me know — I can generate any or all of those for your BAP implementation!
