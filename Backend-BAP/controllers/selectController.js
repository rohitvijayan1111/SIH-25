const axios = require('axios');

exports.handleSelect = async (req, res) => {
  try {
    const txnId = req.transaction_id;
    const { items } = req.body;

    if (!Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: "Items list required" });
    }

    const selectPayload = {
      context: {
        domain: "ondc:agri",
        action: "select",
        core_version: "1.2.0",
        country: "IND",
        city: "std:080",
        transaction_id: txnId,
        message_id: txnId,
        timestamp: new Date().toISOString(),
        bap_id: "bap.agri.app",
        bap_uri: "https://bap.agri.app"
      },
      message: {
        catalog: {
          items
        }
      }
    };

    const bppEndpoint = "http://localhost:3000/bpp/on_select";
    const bppResponse = await axios.post(bppEndpoint, selectPayload, {
      headers: {
        'x-transaction-id': txnId,
        'Content-Type': 'application/json'
      }
    });

    res.status(200).json({
      message: "✅ /select forwarded to BPP",
      transaction_id: txnId,
      bpp_response: bppResponse.data
    });

  } catch (error) {
    console.error("❌ Error in /select:", error.message);
    res.status(500).json({ error: "Failed to call BPP /on_select" });
  }
};
