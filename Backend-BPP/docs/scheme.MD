Here is the **clean, production-ready SQL script** and explanation to create your **`bpp_agri_supplier_db` database** for the **BPP (Beckn Protocol Provider – Supply Side)**.

---

## ✅ Final SQL Schema: `bpp_agri_supplier_db`

```sql
-- STEP 1: Create the database
CREATE DATABASE bpp_agri_supplier_db;

-- STEP 2: Connect to the database
\c bpp_agri_supplier_db

-- 1. Farmers Table
CREATE TABLE farmers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    farm_location TEXT,
    organic_certified BOOLEAN DEFAULT FALSE,
    kyc_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Products Table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    farmer_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('crop','dairy','livestock','tool','fertilizer','seed')) NOT NULL,
    unit VARCHAR(20),
    stock INT DEFAULT 0,
    organic BOOLEAN DEFAULT FALSE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id) ON DELETE CASCADE
);

-- 3. Price List Table (Dynamic pricing)
CREATE TABLE price_list (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    price_per_unit DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- 4. Fulfillments Table
CREATE TABLE fulfillments (
    id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    bpp_product_id INT NOT NULL,
    farmer_id INT NOT NULL,
    status VARCHAR(20) DEFAULT 'RECEIVED' CHECK (status IN ('RECEIVED','PROCESSING','SHIPPED','DELIVERED','CANCELLED')),
    estimated_delivery TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bpp_product_id) REFERENCES products(id),
    FOREIGN KEY (farmer_id) REFERENCES farmers(id)
);

-- 5. Logistics Providers Table
CREATE TABLE logistics_providers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(50),
    capacity_kg INT,
    base_price DECIMAL(10,2),
    location TEXT,
    availability BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. Inventory Logs Table
CREATE TABLE inventory_logs (
    id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    change_type VARCHAR(10) CHECK (change_type IN ('IN','OUT')) NOT NULL,
    quantity INT NOT NULL,
    reason TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);

-- 7. Ratings Table
CREATE TABLE ratings (
    id SERIAL PRIMARY KEY,
    user_id INT NOT NULL,
    bpp_id VARCHAR(100),
    product_id INT,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id)
);
```

---

## 📘 Table Summary

| Table Name            | Description                                  |
| --------------------- | -------------------------------------------- |
| `farmers`             | Farmer details and KYC                       |
| `products`            | Crops, dairy, tools listed by farmers        |
| `price_list`          | Time-based dynamic pricing for products      |
| `fulfillments`        | Tracks order status for each product         |
| `logistics_providers` | Delivery partner metadata (truck, location)  |
| `inventory_logs`      | Records IN/OUT entries for product inventory |
| `ratings`             | Ratings by buyers for BPP and its products   |

---


