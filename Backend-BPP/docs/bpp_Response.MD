{
  "context": {
    "domain": "agri.bpp",
    "action": "on_confirm",
    "transaction_id": "order-789",
    "message_id": "msg-1718874900000",
    "timestamp": "2025-06-20T10:15:00.000Z"
  },
  "message": {
    "order": {
      "id": "order-789",
      "provider": {
        "id": "farmer-101",
        "descriptor": {
          "name": "Green Farm Produce",
          "images": [
            "https://cdn.agri/images/farm.jpg"
          ]
        }
      },
      "items": [
        {
          "id": "product-1b1de851",
          "descriptor": {
            "name": "Organic Tomatoes",
            "images": [
              "https://cdn.agri/images/tomato.jpg"
            ]
          },
          "quantity": {
            "count": 5
          },
          "price": {
            "currency": "INR",
            "value": "25.00"
          },
          "tags": {
            "organic": true
          }
        }
      ],
      "quote": {
        "price": {
          "currency": "INR",
          "value": "125.00"
        },
        "breakup": [
          {
            "title": "Organic Tomatoes",
            "price": {
              "currency": "INR",
              "value": "125.00"
            }
          }
        ]
      },
      "payment": {
        "type": "ON-ORDER",
        "status": "PAID",
        "transaction_id": "txn-001"
      },
      "fulfillment": {
        "id": "ffm-19fce7ab",
        "type": "Delivery",
        "start": {
          "location": {
            "gps": "17.385044,78.486671",
            "address": "Plot 5, Village Road, Telangana"
          }
        },
        "end": {
          "location": {
            "gps": "17.123456,78.654321",
            "address": "User Home, Hyderabad"
          },
          "estimated_delivery": "2025-06-25T10:00:00Z"
        },
        "status": "RECEIVED"
      }
    }
  }
}
