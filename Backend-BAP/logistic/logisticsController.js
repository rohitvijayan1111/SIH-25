// const axios = require("axios");

exports.searchLogistics = async (req, res) => {
  try {
    // 1️⃣ Take frontend payload or use defaults
    const start = req.body.start || { gps: "13.0827,80.2707", address: "Warehouse, Chennai" };
    const end = req.body.end || { gps: "12.9716,77.5946", address: "Customer Address, Bangalore" };
    const weight_kg = req.body.weight_kg || 5;

    const transactionId = `txn-${Date.now()}`;
    const messageId = `msg-${Date.now()}`;

    const searchPayload = {
      context: {
        domain: "ONDC:LOG10",
        action: "search",
        version: "1.1.0",
        bap_id: "your-bap.example.com",
        bap_uri: "https://your-bap.example.com/ondc",
        transaction_id: transactionId,
        message_id: messageId,
        timestamp: new Date().toISOString(),
        ttl: "PT30S"
      },
      message: {
        intent: {
          fulfillment: {
            type: "Delivery",
            start: { location: start },
            end: { location: end },
            tags: [
              { code: "weight", value: weight_kg.toString() }
            ]
          }
        }
      }
    };

    // // 2️⃣ Call ONDC gateway asynchronously
    // axios.post("https://gateway.ondc.org/search", searchPayload, {
    //   headers: { "Content-Type": "application/json" }
    // }).catch(err => {
    //   console.error("Logistics /search failed:", err.message);
    // });

    // 3️⃣ Realistic ONDC /on_search mock response
    const defaultOndcResponse = {
      context: {
        domain: "ONDC:LOG10",
        action: "on_search",
        version: "1.1.0",
        bpp_id: "mock-logistics-bpp.ondc.org",
        bpp_uri: "https://mock-logistics-bpp.ondc.org",
        transaction_id: transactionId,
        message_id: messageId,
        timestamp: new Date().toISOString()
      },
      message: {
        catalog: {
          providers: [
            {
              id: "DELHIVERY123",
              descriptor: { name: "Delhivery Express" },
              fulfillments: [
                {
                  id: "f1",
                  type: "Delivery",
                  tracking: true
                }
              ],
              items: [
                {
                  id: "DEL-STD",
                  descriptor: { name: "Standard Delivery" },
                  category_id: "Immediate",
                  fulfillment_id: "f1",
                  price: { currency: "INR", value: "120.00" },
                  time: { duration: "PT48H" }
                }
              ]
            },
            {
              id: "BLUEDART001",
              descriptor: { name: "Bluedart Premium" },
              fulfillments: [
                {
                  id: "f2",
                  type: "Delivery",
                  tracking: true
                }
              ],
              items: [
                {
                  id: "BD-EXP",
                  descriptor: { name: "Express Delivery" },
                  category_id: "Immediate",
                  fulfillment_id: "f2",
                  price: { currency: "INR", value: "150.00" },
                  time: { duration: "PT24H" }
                }
              ]
            }
          ]
        }
      }
    };

    res.json(defaultOndcResponse);

  } catch (error) {
    console.error("Error in searchLogistics:", error);
    res.status(500).json({ error: "Internal Server Error" });
  }
};
