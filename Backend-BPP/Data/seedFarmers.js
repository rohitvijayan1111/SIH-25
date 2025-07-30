// seedFarmers.js
const sequelize = require('../config/sequelize'); // fix path if needed
const { DataTypes } = require('sequelize'); 
const Farmer = require('../model/farmer')(sequelize, DataTypes);        // fix path if needed

const farmersData = [
  {
    id: "dbd62bb4-618d-454a-9a90-523317ab3734",
    name: "Raj Patel",
    phone: "9876543001",
    farm_location: "Gujarat - Ahmedabad",
    organic_certified: true,
    kyc_id: "KYC001",
    created_at: new Date("2025-07-18T12:51:20.020687+05:30"),
    updated_at: new Date("2025-07-18T12:51:20.020687+05:30")
  },
  {
    id: "690c54df-470f-4508-89de-db2648d7d260",
    name: "Priya Sharma",
    phone: "9876543002",
    farm_location: "Punjab - Ludhiana",
    organic_certified: false,
    kyc_id: "KYC002",
    created_at: new Date("2025-07-18T12:51:20.020687+05:30"),
    updated_at: new Date("2025-07-18T12:51:20.020687+05:30")
  },
  {
    id: "910d34a9-b9c0-489a-b7e1-73657d0e4503",
    name: "Arjun Reddy",
    phone: "9876543003",
    farm_location: "Telangana - Hyderabad",
    organic_certified: true,
    kyc_id: "KYC003",
    created_at: new Date("2025-07-18T12:51:20.020687+05:30"),
    updated_at: new Date("2025-07-18T12:51:20.020687+05:30")
  }
];

async function seed() {
  try {
    await sequelize.authenticate();
    console.log('Database connected successfully.');

    // Sync the model without dropping existing data:
    await Farmer.sync();

    // Insert data:
    await Farmer.bulkCreate(farmersData);

    console.log('Farmers data inserted successfully.');
    
    await sequelize.close();
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}

seed();
