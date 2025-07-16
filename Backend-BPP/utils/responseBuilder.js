exports.buildOnSearchResponse = (products) => {
  const uniqueProviders = {};
  const uniqueFulfillments = {};
  const itemMap = {};

  for (const prod of products) {
    // Track unique provider
    //  console.log(prod);
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
      type: prod.fulfillment_type || 'Self-Pickup',
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
                  end: prod.estimated_delivery
                }
              }
            }
          }
        : {})
    };

    // Group batches under product
    if (!itemMap[prod.product_id]) {
      itemMap[prod.product_id] = {
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
    count: prod.available_quantity || 0  // Use prod.stock directly
  },
          unitized: {
            measure: {
              unit: prod.unit || 'unit'
            }
          }
        },
        batches: [],
        tags: prod.organic ? ['organic'] : []
      };
    }

    // Add batch
    itemMap[prod.product_id].batches.push({
      price: {
        currency: 'INR',
        value: Number(prod.price_per_unit).toFixed(2)
      },
      available_quantity: prod.quantity,
      expiry_date: prod.expiry_date
    });
  }

  return {
    context: {
      domain: 'agri.bpp',
      action: 'on_search',
      timestamp: new Date().toISOString()
    },
    message: {
      catalog: {
        items: Object.values(itemMap),
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



