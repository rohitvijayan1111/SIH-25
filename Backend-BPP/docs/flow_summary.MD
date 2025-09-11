Here is the **flow summary for all BPP backend use cases** in the same style as you requested, covering each Beckn API callback step-by-step:

---

### 🔍 1. `/on_search`

```
POST /bpp/on_search
     ↓
onSearchController.js
     ↓
inventoryService.js
     ↓
productModel.js + priceListModel.js
     ↓
responseBuilder.js
     ↓
Final JSON → Sent back to BAP
```

---

### 🛒 2. `/on_select`

```
POST /bpp/on_select
     ↓
onSelectController.js
     ↓
inventoryService.js + pricingService.js
     ↓
productModel.js + priceListModel.js (+ inventoryLogModel.js if needed)
     ↓
responseBuilder.js
     ↓
Item & fulfillment info JSON → Sent back to BAP
```

---

### ✅ 3. `/on_confirm`

```
POST /bpp/on_confirm
     ↓
onConfirmController.js
     ↓
inventoryService.js
     ↓
productModel.js → Decrease stock
fulfillmentModel.js → Create fulfillment entry
inventoryLogModel.js → Log inventory OUT
     ↓
responseBuilder.js
     ↓
Order confirmation JSON → Sent back to BAP
```

---

### 🚚 4. Logistics Partner Discovery (Internal)

```
[Triggered Internally]
     ↓
logisticsService.js
     ↓
logisticsProviderModel.js → Match based on availability/location/capacity
     ↓
Matched partner info → Used during fulfillment
```

---

### 📦 5. `/on_status`

```
POST /bpp/on_status
     ↓
onStatusController.js
     ↓
fulfillmentModel.js
     ↓
responseBuilder.js
     ↓
Current order status + ETA → Sent back to BAP
```

---

### 📈 6. Inventory Tracking (Internal)

```
[Called from multiple points: confirm, cancel, restock]
     ↓
inventoryService.js
     ↓
inventoryLogModel.js → Insert IN/OUT log
productModel.js → Update stock
     ↓
Logged for analytics and audit
```

---

### 🧾 7. `/on_bill`

```
POST /bpp/on_bill
     ↓
onBillController.js
     ↓
pricingService.js + fulfillmentModel.js
     ↓
priceListModel.js + productModel.js
     ↓
responseBuilder.js
     ↓
Final charges → Sent back to BAP
```

---

### ✍️ 8. `/on_rating`

```
POST /bpp/on_rating
     ↓
onRatingController.js
     ↓
ratingModel.js → Insert rating & review
     ↓
Acknowledgment JSON → Sent back to BAP
```

---

### ❌ 9. `/on_cancel`

```
POST /bpp/on_cancel
     ↓
onCancelController.js
     ↓
fulfillmentModel.js → Update status = 'CANCELLED'
productModel.js → Add stock back
inventoryLogModel.js → Log stock IN
     ↓
responseBuilder.js
     ↓
Cancellation confirmation JSON → Sent back to BAP
```

---

## 🧠 Summary

Each flow follows this consistent pattern:

```
Route → Controller → Service (business logic) → Model (DB queries) → Response builder → JSON output
```

Let me know if you'd like:

* 📁 Full code for all these use cases
* 🗺️ Visual flow diagram
* 🧪 Postman test cases for each route
* 📦 Docker + PostgreSQL + sample data setup

I can generate any of them!
