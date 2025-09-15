Sure! Let's build a complete **realistic ONDC use case** using your given `/on_select` response.

---

## 🧾 Use Case: **Ajith orders Basmati Rice (10 kg) and Cow Milk (2 litres)**

### 👇 Based on `/on_select` response you shared:

| Product      | Unit Price | Quantity | Subtotal    |
| ------------ | ---------- | -------- | ----------- |
| Basmati Rice | ₹70.00/kg  | 10 kg    | ₹700.00     |
| Cow Milk     | ₹30.00/ltr | 2 ltr    | ₹60.00      |
| **Total**    |            |          | **₹760.00** |

---

## ✅ Step-by-Step ONDC Flow (With Example Payloads)

---

### **1️⃣ BAP Sends `/select`**

Ajith selects 10 kg of rice and 2 litres of milk.

✅ This step already happened — your current example shows BPP’s response `/on_select` with item availability and prices.

---

### **2️⃣ BAP Collects Payment**

💸 The BAP collects ₹760 via UPI.

> 🔒 The BAP records:

```json
"transaction_id": "upi-ajith-txn-001",
"status": "PAID"
```

---

### **3️⃣ BAP Sends `/confirm`**

Now that payment is done, BAP sends:

```json
{
  "context": {
    "domain": "agri.bpp",
    "action": "confirm",
    "transaction_id": "txn-2025-001",
    "message_id": "msg-002",
    "timestamp": "2025-06-20T06:03:00Z"
  },
  "message": {
    "order": {
      "id": "order-2025-ajith-01",
      "items": [
        {
          "id": "00221deb-98ce-46f2-8bf7-16122d2a6046", // Basmati Rice
          "quantity": { "count": 10 }
        },
        {
          "id": "a92c8746-2ca7-4217-8408-a55781806e9c", // Cow Milk
          "quantity": { "count": 2 }
        }
      ],
      "quote": {
        "price": {
          "currency": "INR",
          "value": "760.00"
        },
        "breakup": [
          {
            "title": "Basmati Rice",
            "price": { "currency": "INR", "value": "700.00" }
          },
          {
            "title": "Cow Milk",
            "price": { "currency": "INR", "value": "60.00" }
          }
        ]
      },
      "payment": {
        "type": "ON-ORDER",
        "status": "PAID",
        "transaction_id": "upi-ajith-txn-001"
      },
      "fulfillment": {
        "start": {
          "location": {
            "gps": "10.7867,79.1378",
            "address": "Farmer Market, Thanjavur"
          }
        },
        "end": {
          "location": {
            "gps": "10.8000,79.1400",
            "address": "Ajith's Home, Thanjavur"
          },
          "contact": {
            "phone": "9876543210"
          }
        }
      }
    }
  }
}
```

---

### **4️⃣ BPP Responds with `/on_confirm`**

```json
{
  "context": {
    "domain": "agri.bpp",
    "action": "on_confirm",
    "transaction_id": "txn-2025-001",
    "message_id": "msg-003",
    "timestamp": "2025-06-20T06:03:10Z"
  },
  "message": {
    "order": {
      "id": "order-2025-ajith-01",
      "quote": {
        "price": {
          "currency": "INR",
          "value": "760.00"
        },
        "breakup": [
          {
            "title": "Basmati Rice",
            "price": { "currency": "INR", "value": "700.00" }
          },
          {
            "title": "Cow Milk",
            "price": { "currency": "INR", "value": "60.00" }
          }
        ]
      },
      "payment": {
        "type": "ON-ORDER",
        "status": "PAID",
        "transaction_id": "upi-ajith-txn-001"
      },
      "fulfillment": {
        "id": "ffm-ajith-01",
        "start": {
          "location": {
            "gps": "10.7867,79.1378",
            "address": "Farmer Market, Thanjavur"
          }
        },
        "end": {
          "location": {
            "gps": "10.8000,79.1400",
            "address": "Ajith's Home, Thanjavur"
          }
        },
        "status": "RECEIVED"
      }
    }
  }
}
```

---

## ✅ Summary

| Step            | Description                                    |
| --------------- | ---------------------------------------------- |
| `/on_select`    | Confirms available items and their prices      |
| 🟢 Payment Done | User pays ₹760 via UPI                         |
| `/confirm`      | BAP sends full order **+ payment info**        |
| `/on_confirm`   | BPP confirms order and **echoes back** payment |

---

Would you like the next step (`/on_status` for tracking delivery) as well?


function buildOnConfirmResponse() {
  return {
    context: {
      domain: "agri.bpp",
      action: "on_confirm",
      version: "1.2.0",
      transaction_id: "txn-2025-001",
      message_id: "msg-003",
      timestamp: "2025-06-20T08:15:00Z"
    },
    message: {
      order: {
        id: "order-2025-ajith-01",
        provider: {
          id: "0d08af16-1e96-4b1d-a250-7c7cfaa065a4",
          descriptor: {
            name: "Thanjavur Organic Farmer Group"
          },
          locations: ["loc-thanjavur-001"]
        },
        items: [
          {
            id: "00221deb-98ce-46f2-8bf7-16122d2a6046",
            quantity: { count: 10 },
            fulfillment_id: "ffm-ajith-001"
          },
          {
            id: "a92c8746-2ca7-4217-8408-a55781806e9c",
            quantity: { count: 2 },
            fulfillment_id: "ffm-ajith-001"
          }
        ],
        quote: {
          price: {
            currency: "INR",
            value: "760.00"
          },
          breakup: [
            {
              title: "Basmati Rice (10 kg)",
              price: {
                currency: "INR",
                value: "700.00"
              }
            },
            {
              title: "Cow Milk (2 litre)",
              price: {
                currency: "INR",
                value: "60.00"
              }
            }
          ]
        },
        fulfillment: {
          id: "ffm-ajith-001",
          type: "Delivery",
          state: {
            descriptor: {
              code: "CONFIRMED"
            }
          },
          start: {
            location: {
              id: "loc-thanjavur-001",
              gps: "10.7867,79.1378",
              address: "Farmer Market, Thanjavur"
            }
          },
          end: {
            location: {
              gps: "10.8000,79.1400",
              address: "Ajith's Home, Thanjavur"
            },
            contact: {
              phone: "9876543210"
            }
          },
          estimated_delivery: "2025-06-23T04:30:00Z"
        },
        billing: {
          name: "Ajith Kumar",
          address: "Ajith's Home, Thanjavur",
          phone: "9876543210",
          email: "ajith@example.com"
        },
        payment: {
          type: "ON-ORDER",
          status: "PAID",
          collected_by: "BAP",
          transaction_id: "upi-ajith-txn-001"
        },
        customer: {
          person: {
            name: "Ajith Kumar"
          },
          contact: {
            phone: "9876543210",
            email: "ajith@example.com"
          }
        }
      }
    }
  };
}

// To use:
const response = buildOnConfirmResponse();
console.log(JSON.stringify(response, null, 2));
