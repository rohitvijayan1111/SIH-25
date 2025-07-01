exports.buildOnSearchResponse = (products) => {
  const uniqueProviders = {};
  const uniqueFulfillments = {};

  const items = products.map(prod => {
    // Track unique provider
    uniqueProviders[prod.farmer_id] = {
      id: `farmer-${prod.farmer_id}`,
      descriptor: { name: prod.farmer_name },
      locations: [
        {
          id: prod.location_code,
          gps: prod.location_gps,
          address: prod.location_address
        }
      ]
    };

    // Track unique fulfillment
uniqueFulfillments[prod.fulfillment_code] = {
  id: prod.fulfillment_code,
  type: prod.fulfillment_type || 'Self-Pickup', // Use type from DB, fallback to Self-Pickup
  start: {
    location: {
      gps: prod.fulfillment_gps,
      address: prod.fulfillment_address
    }
  },
  ...(prod.estimated_delivery && prod.fulfillment_type === 'Delivery'
    ? {
        end: {
          time: {
            range: {
              end: prod.estimated_delivery // ISO string already formatted in service
            }
          }
        }
      }
    : {})
};


    return {
      id: prod.product_id.toString(),
      category_id: prod.type.toUpperCase(), 
      descriptor: {
        name: prod.product_name,
        images: [prod.image_url]
      },
      provider: {
        id: `farmer-${prod.farmer_id}`
      },
      location_id: prod.location_code,
      fulfillment_id: prod.fulfillment_code,
      quantity: {
        available: {
          count: prod.stock
        },
        unitized: {
          measure: {
            unit: prod.unit || 'unit'
          }
        }
      },
      price: {
        currency: 'INR',
        value: Number(prod.price_per_unit).toFixed(2)
      },
      tags: prod.organic ? ['organic'] : []
    };
  });

  return {
    context: {
      domain: 'agri.bpp',
      action: 'on_search',
      timestamp: new Date().toISOString()
    },
    message: {
      catalog: {
        items,
        providers: Object.values(uniqueProviders),
        fulfillments: Object.values(uniqueFulfillments)
      }
    }
  };
};



exports.buildOnRatingResponse = (context) => {
  return {
    context: {
      ...contextFromReq,
      action: "on_rating",
      timestamp: new Date().toISOString(),
      // message_id: `msg-${Math.random().toString(36).substring(2, 12)}`,
    },
    message: {
      ack: {
        status: "ACK",
      },
    },
  };
};



