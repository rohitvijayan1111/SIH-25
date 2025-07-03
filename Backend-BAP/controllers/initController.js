const axios = require('axios');

exports.handleInit = async (req, res) => {
  try {
    const txnId = req.transaction_id; // set by middleware
    const { provider_id, items, delivery_address } = req.body;

    // Validate essential fields
    if (!provider_id || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: "Missing provider_id or items" });
    }

    if (!delivery_address?.gps || !delivery_address?.address) {
      return res.status(400).json({ error: "Invalid delivery address" });
    }

    
    const initPayload = {
      context: {
        domain: "ondc:agri",
        country: "IND",
        action: "init",
        core_version: "1.2.0",
        bap_id: "bap.agri.app",
        bap_uri: "https://bap.agri.app",
        transaction_id: txnId,
        message_id: txnId, // often same as transaction_id
        timestamp: new Date().toISOString()
      },
      message: {
        order: {
          provider: {
            id: provider_id
          },
          items: items.map((item) => ({
            id: item.id,
            quantity: {
              count: item.quantity || 1
            },
            fulfillment_id: item.fulfillment_id
          })),
          fulfillment: {
            end: {
              location: {
                gps: delivery_address.gps,
                address: delivery_address.address
              }
            }
          }
        }
      }
    };

    // Send to BPP
    const bppEndpoint = "http://localhost:3000/bpp/on_init";
    const bppResponse = await axios.post(bppEndpoint, initPayload, {
      headers: {
        'x-transaction-id': txnId,
        'Content-Type': 'application/json'
      }
    });

    res.status(200).json({
      message: "✅ /init processed and forwarded to BPP",
      transaction_id: txnId,
      bpp_response: bppResponse.data
    });

  } catch (err) {
    console.error("❌ Error in /init:", err.message);
    res.status(500).json({ error: "BAP init failed" });
  }
};
