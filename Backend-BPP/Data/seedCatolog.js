// seedFarmers.js
const sequelize = require('../config/sequelize'); // fix path if needed
const { DataTypes } = require('sequelize');
const CatalogFulfillment = require('../model/catalogFulfillment')(
  sequelize,
  DataTypes
); // fix path if needed

const fulfillmentsData = [
  {
    id: 'f3b3a8e6-7c0e-4d29-bf81-3e5c4a5d7b01', // UUID (replace or generate)
    fulfillment_code: 'FULFILL001',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260', // Priya Sharma
    type: 'doorstep',
    gps: '30.9010,75.8573',
    address: 'Ludhiana, Punjab',
    estimated_delivery: new Date('2025-08-07T10:00:00+05:30'),
    updated_at: new Date(),
  },
  {
    id: 'd2c6b0c9-5a5c-44de-8c3f-75875100a6f2',
    fulfillment_code: 'FULFILL002',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503', // Arjun Reddy
    type: 'pickup',
    gps: '17.3850,78.4867',
    address: 'Hyderabad, Telangana',
    estimated_delivery: new Date('2025-08-08T14:00:00+05:30'),
    updated_at: new Date(),
  },
  {
    id: 'a4e7adbe-8c5b-4a06-a123-7c59c08ec39b',
    fulfillment_code: 'FULFILL003',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734', // Raj Patel
    type: 'doorstep',
    gps: '23.0225,72.5714',
    address: 'Ahmedabad, Gujarat',
    estimated_delivery: new Date('2025-08-09T16:00:00+05:30'),
    updated_at: new Date(),
  },
];

async function seed() {
  try {
    await sequelize.authenticate();
    console.log('Database connected successfully.');

    // Sync the model without dropping existing data:
    await CatalogFulfillment.sync();

    // Insert data:
    await CatalogFulfillment.bulkCreate(fulfillmentsData);

    console.log('Fulfillments data inserted successfully.');

    await sequelize.close();
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}

seed();
