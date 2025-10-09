Absolutely! Let’s make **detailed backend endpoint use cases** for your `bpp_agri_supplier_db` considering your **generic `products` table** and **farmer-specific `batches` table**. I’ll include **purpose, input, output, validations, and example responses**.

---

# **1️⃣ Products Endpoints (Generic Catalog)**

### **1.1 Add a Product**

* **Method:** `POST`
* **Endpoint:** `/products`
* **Purpose:** Add a new product to the catalog (admin only).
* **Input (JSON):**

```json
{
  "name": "Apple",
  "type": "crop",
  "unit": "kg",
  "description": "Fresh apples",
  "image_url": "https://example.com/apple.jpg"
}
```

* **Validations:**

  * `name` and `type` are required.
  * `type` must be one of: `crop, dairy, livestock, tool, fertilizer, seed`.
* **Output:**

```json
{
  "id": "uuid-apple",
  "name": "Apple",
  "type": "crop",
  "unit": "kg",
  "description": "Fresh apples",
  "image_url": "https://example.com/apple.jpg",
  "stock": 0,
  "created_at": "2025-10-07T12:00:00Z"
}
```

---

### **1.2 Get All Products**

* **Method:** `GET`
* **Endpoint:** `/products`
* **Purpose:** Fetch all products with optional filters.
* **Query Parameters (Optional):**

  * `type=crop`
  * `name=apple` (partial search)
* **Output:**

```json
[
  {
    "id": "uuid-apple",
    "name": "Apple",
    "type": "crop",
    "unit": "kg",
    "description": "Fresh apples",
    "image_url": "...",
    "stock": 0,
    "created_at": "2025-10-07T12:00:00Z"
  },
  {
    "id": "uuid-banana",
    "name": "Banana",
    "type": "crop",
    "unit": "kg",
    "description": "Fresh bananas",
    "image_url": "...",
    "stock": 0,
    "created_at": "2025-10-07T12:05:00Z"
  }
]
```

---

### **1.3 Get Product Details**

* **Method:** `GET`
* **Endpoint:** `/products/:id`
* **Purpose:** Get details of a single product.
* **Path Parameter:** `id` → Product UUID
* **Output:**

```json
{
  "id": "uuid-apple",
  "name": "Apple",
  "type": "crop",
  "unit": "kg",
  "description": "Fresh apples",
  "image_url": "...",
  "stock": 0,
  "created_at": "2025-10-07T12:00:00Z"
}
```

---

### **1.4 Update Product**

* **Method:** `PUT`
* **Endpoint:** `/products/:id`
* **Purpose:** Update product details (admin only).
* **Input (JSON):** Any fields to update:

```json
{
  "name": "Green Apple",
  "unit": "kg",
  "description": "Fresh green apples"
}
```

* **Output:** Updated product object.

---

### **1.5 Delete Product**

* **Method:** `DELETE`
* **Endpoint:** `/products/:id`
* **Purpose:** Delete a product.
* **Effect:** Deletes product and cascades to batches and dependent tables.
* **Output:**

```json
{
  "message": "Product deleted successfully"
}
```

---

# **2️⃣ Batches Endpoints (Farmer-Specific)**

### **2.1 Add Batch**

* **Method:** `POST`
* **Endpoint:** `/batches`
* **Purpose:** Farmer adds a batch for a specific product.
* **Input (JSON):**

```json
{
  "product_id": "uuid-apple",
  "farmer_id": "uuid-farmerA",
  "initial_qty_kg": 150,
  "current_qty_kg": 150,
  "unit": "kg",
  "organic": true,
  "harvest_date": "2025-10-05",
  "location_name": "Farm A"
}
```

* **Validations:**

  * `product_id`, `farmer_id`, `initial_qty_kg`, `current_qty_kg` required.
  * `current_qty_kg <= initial_qty_kg`.
* **Output:** Created batch object.

---

### **2.2 Update Batch**

* **Method:** `PUT`
* **Endpoint:** `/batches/:id`
* **Purpose:** Update farmer batch info.
* **Input (JSON):**

```json
{
  "current_qty_kg": 120,
  "organic": false,
  "status": "AVAILABLE"
}
```

* **Output:** Updated batch object.

---

### **2.3 Get Batch Details**

* **Method:** `GET`
* **Endpoint:** `/batches/:id`
* **Purpose:** Get details of a specific batch.
* **Output:**

```json
{
  "id": "batch-1",
  "product_id": "uuid-apple",
  "farmer_id": "uuid-farmerA",
  "initial_qty_kg": 150,
  "current_qty_kg": 120,
  "unit": "kg",
  "organic": true,
  "harvest_date": "2025-10-05",
  "location_name": "Farm A",
  "status": "AVAILABLE"
}
```

---

### **2.4 Delete Batch**

* **Method:** `DELETE`
* **Endpoint:** `/batches/:id`
* **Purpose:** Remove a batch.
* **Output:**

```json
{
  "message": "Batch deleted successfully"
}
```

---

### **2.5 List Batches of a Product**

* **Method:** `GET`
* **Endpoint:** `/products/:productId/batches`
* **Purpose:** List all batches for a product grouped by farmer.
* **Output:**

```json
[
  {
    "id": "batch-1",
    "farmer_id": "farmerA",
    "initial_qty_kg": 150,
    "current_qty_kg": 120,
    "organic": true,
    "location_name": "Farm A",
    "harvest_date": "2025-10-05"
  },
  {
    "id": "batch-2",
    "farmer_id": "farmerB",
    "initial_qty_kg": 100,
    "current_qty_kg": 80,
    "organic": false,
    "location_name": "Farm B",
    "harvest_date": "2025-10-06"
  }
]
```

---

# **3️⃣ Optional Combined Endpoint**

### **Get Products with Their Batches**

* **Method:** `GET`
* **Endpoint:** `/products-with-batches`
* **Purpose:** Frontend displays product once with all farmer batches.
* **Query Parameters:** Optional: `type=crop`, `organic=true`
* **Output Example:**

```json
[
  {
    "id": "uuid-apple",
    "name": "Apple",
    "type": "crop",
    "unit": "kg",
    "batches": [
      {
        "id": "batch-1",
        "farmer_id": "farmerA",
        "current_qty_kg": 120,
        "organic": true
      },
      {
        "id": "batch-2",
        "farmer_id": "farmerB",
        "current_qty_kg": 80,
        "organic": false
      }
    ]
  }
]
```

---

If you want, I can **also provide a full Express.js + PostgreSQL implementation** for **all these endpoints**, including SQL queries for aggregating stock and fetching batches by product.

Do you want me to do that next?
