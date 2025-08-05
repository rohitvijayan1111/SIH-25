// seedFarmers.js
const sequelize = require('../config/sequelize'); // fix path if needed
const { DataTypes } = require('sequelize');
const Location = require('../model/location')(sequelize, DataTypes); // fix path if needed

const locationsData = [
  {
    // Priya Sharma
    id: '690c54df-470f-4508-89de-db2648d7d260', // Use UUIDv4, or omit if auto
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260', // Priya Sharma's id
    location_code: 'Punjab-Ludhiana',
    gps: '30.9010,75.8573',
    address: 'Ludhiana, Punjab',
    created_at: new Date(),
  },
  {
    // Arjun Reddy
    id: '910d34a9-b9c0-489a-b7e1-73657d0e4503', // Use UUIDv4, or omit if auto
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503', // Arjun Reddy's id
    location_code: 'Telangana-Hyderabad',
    gps: '17.3850,78.4867',
    address: 'Hyderabad, Telangana',
    created_at: new Date(),
  },
  {
    // Raj Patel
    id: 'dbd62bb4-618d-454a-9a90-523317ab3734', // Use UUIDv4, or omit if auto
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734', // Raj Patel's id
    location_code: 'Gujarat-Ahmedabad',
    gps: '23.0225,72.5714',
    address: 'Ahmedabad, Gujarat',
    created_at: new Date(),
  },
];

async function seed() {
  try {
    await sequelize.authenticate();
    console.log('Database connected successfully.');

    // Sync the model without dropping existing data:
    await Location.sync();

    // Insert data:
    await Location.bulkCreate(locationsData);

    console.log('Locations data inserted successfully.');

    await sequelize.close();
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}

seed();
