Great! Since you now want to **create the database and use UUIDs** (instead of `SERIAL`), here's the **corrected SQL schema** using `UUID` for all primary and foreign keys, with everything ready for **ONDC integration**.

---

## ✅ Final SQL Schema with UUIDs for `bpp_agri_supplier_db`

> 🔐 Uses `gen_random_uuid()` from the `pgcrypto` extension.

### 🔹 STEP 1: Create Database and Enable UUID Support

```sql
-- Create the database
CREATE DATABASE bpp_agri_supplier_db;
```

### 🔹 STEP 2: Connect and Enable Extension

```sql
-- Connect to the database
\c bpp_agri_supplier_db

-- Enable pgcrypto for UUID generation
CREATE EXTENSION IF NOT EXISTS "pgcrypto";
```

---

### 🧱 Full Schema with UUIDs

```sql
-- 1. Farmers Table
CREATE TABLE farmers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    farm_location TEXT,
    organic_certified BOOLEAN DEFAULT FALSE,
    kyc_id VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Locations Table
CREATE TABLE locations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    farmer_id UUID NOT NULL,
    location_code VARCHAR(100) UNIQUE NOT NULL,
    gps VARCHAR(50),
    address TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id) ON DELETE CASCADE
);

-- 3. Products Table
CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    farmer_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    type VARCHAR(20) CHECK (type IN ('crop','dairy','livestock','tool','fertilizer','seed')) NOT NULL,
    unit VARCHAR(20),
    stock INT DEFAULT 0,
    organic BOOLEAN DEFAULT FALSE,
    description TEXT,
    image_url TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id) ON DELETE CASCADE
);

-- 4. Price List Table
CREATE TABLE price_list (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL,
    price_per_unit DECIMAL(10,2) NOT NULL,
    valid_from DATE NOT NULL,
    valid_to DATE NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- 5. Catalog Fulfillments Table
CREATE TABLE catalog_fulfillments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    fulfillment_code VARCHAR(100) UNIQUE NOT NULL,
    farmer_id UUID NOT NULL,
    type VARCHAR(50) DEFAULT 'Self-Pickup',
    gps VARCHAR(50),
    address TEXT NOT NULL,
    estimated_delivery TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id) ON DELETE CASCADE
);

-- 6. Order Fulfillments Table
CREATE TABLE order_fulfillments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id TEXT NOT NULL,
    bpp_product_id UUID NOT NULL,
    farmer_id UUID NOT NULL,
    status VARCHAR(20) CHECK (status IN ('RECEIVED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED')) DEFAULT 'RECEIVED',
    estimated_delivery TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bpp_product_id) REFERENCES products(id),
    FOREIGN KEY (farmer_id) REFERENCES farmers(id)
);

-- 7. Logistics Providers Table
CREATE TABLE logistics_providers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR(100) NOT NULL,
    vehicle_type VARCHAR(50),
    capacity_kg INT,
    base_price DECIMAL(10,2),
    location TEXT,
    availability BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 8. Inventory Logs Table
CREATE TABLE inventory_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    product_id UUID NOT NULL,
    change_type VARCHAR(10) CHECK (change_type IN ('IN','OUT')) NOT NULL,
    quantity INT NOT NULL,
    reason TEXT,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    bap_order_id TEXT UNIQUE,
    farmer_id UUID NOT NULL,
    total_price DECIMAL(10,2),
    payment_status VARCHAR(20),
    delivery_address TEXT,
    buyer_contact TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (farmer_id) REFERENCES farmers(id)
);

-- 9. Ratings Table
CREATE TABLE ratings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL,
    bpp_id VARCHAR(100),
    product_id UUID,
    rating INT CHECK(rating BETWEEN 1 AND 5),
    review TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);
```

---

## ✅ Ready for ONDC Integration

| ONDC Field          | DB Column                               |
| ------------------- | --------------------------------------- |
| `location_id`       | `locations.location_code`               |
| `fulfillment_id`    | `catalog_fulfillments.fulfillment_code` |
| `descriptor.images` | `products.image_url`                    |
| `tags`              | derived from `organic` boolean          |

---

## 📦 Bonus: Want Sample INSERTs or Node.js Model?

Let me know and I’ll give you:

* ✅ Example data insert scripts
* ✅ Sequelize/Mongoose model structure for UUIDs
* ✅ ONDC response builder template

Would you like that?
