
--1.### ✅ File: `sample_on_search_response.json`

```json
{
    "context": {
        "domain": "agri.bpp",
        "action": "on_search",
        "timestamp": "2025-06-19T14:04:44.359Z"
    },
    "message": {
        "catalog": {
            "items": [
                {
                    "id": "00221deb-98ce-46f2-8bf7-16122d2a6046",
                    "descriptor": {
                        "name": "Basmati Rice",
                        "images": [
                            "https://cdn.example.com/images/basmati-rice.jpg"
                        ]
                    },
                    "provider": {
                        "id": "farmer-0d08af16-1e96-4b1d-a250-7c7cfaa065a4"
                    },
                    "location_id": "location-farmer-1",
                    "fulfillment_id": "pickup-farmer-1",
                    "quantity": {
                        "available": {
                            "count": 500
                        },
                        "unitized": {
                            "measure": {
                                "unit": "kg"
                            }
                        }
                    },
                    "price": {
                        "currency": "INR",
                        "value": "70.00"
                    },
                    "tags": [
                        "organic"
                    ]
                },
                {
                    "id": "a92c8746-2ca7-4217-8408-a55781806e9c",
                    "descriptor": {
                        "name": "Cow Milk",
                        "images": [
                            "https://cdn.example.com/images/milk.jpg"
                        ]
                    },
                    "provider": {
                        "id": "farmer-0d08af16-1e96-4b1d-a250-7c7cfaa065a4"
                    },
                    "location_id": "location-farmer-1",
                    "fulfillment_id": "pickup-farmer-1",
                    "quantity": {
                        "available": {
                            "count": 200
                        },
                        "unitized": {
                            "measure": {
                                "unit": "litre"
                            }
                        }
                    },
                    "price": {
                        "currency": "INR",
                        "value": "30.00"
                    },
                    "tags": [
                        "organic"
                    ]
                },
                {
                    "id": "085f2cc4-4a19-4e65-9eaf-4df39a1a0c47",
                    "descriptor": {
                        "name": "Goat",
                        "images": [
                            "https://cdn.example.com/images/goat.jpg"
                        ]
                    },
                    "provider": {
                        "id": "farmer-0d08af16-1e96-4b1d-a250-7c7cfaa065a4"
                    },
                    "location_id": "location-farmer-1",
                    "fulfillment_id": "pickup-farmer-1",
                    "quantity": {
                        "available": {
                            "count": 10
                        },
                        "unitized": {
                            "measure": {
                                "unit": "unit"
                            }
                        }
                    },
                    "price": {
                        "currency": "INR",
                        "value": "5000.00"
                    },
                    "tags": []
                }
            ],
            "providers": [
                {
                    "id": "farmer-0d08af16-1e96-4b1d-a250-7c7cfaa065a4",
                    "descriptor": {
                        "name": "Thanjavur Organic Farmer Group"
                    },
                    "locations": [
                        {
                            "id": "location-farmer-1",
                            "gps": "10.7867,79.1378",
                            "address": "Farmer Market, Thanjavur"
                        }
                    ]
                }
            ],
            "fulfillments": [
                {
                    "id": "pickup-farmer-1",
                    "type": "Self-Pickup",
                    "start": {
                        "location": {
                            "gps": "10.7867,79.1378",
                            "address": "Farmer Market, Thanjavur"
                        }
                    }
                }
            ]
        }
    }
}
