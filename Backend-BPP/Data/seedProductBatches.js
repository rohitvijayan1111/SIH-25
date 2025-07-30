// seedFarmers.js
const sequelize = require('../config/sequelize'); // fix path if needed
const { DataTypes } = require('sequelize');
const  productBatch= require('../model/productBatch')(sequelize, DataTypes); // fix path if needed

const productBatchData = [
  {
    id: 'bd8f6aef-d5ee-4eb1-8901-3bdeac7e734a',
    product_id: '1a51ceef-95f3-4817-a239-213f315cf04e',
    price_per_unit: 25.5,
    quantity: 100,
    manufactured_on: '2024-12-01',
    expiry_date: '2025-12-01',
  },
  {
    id: 'cd2c83dc-cde3-4b1b-8a14-f19e4e528dc0',
    product_id: '1c704464-1549-4253-b9c8-a0ef7a19e2ba',
    price_per_unit: 13.75,
    quantity: 250,
    manufactured_on: '2025-01-15',
    expiry_date: '2026-01-15',
  },
  {
    id: '9fb7d138-83fc-49dc-9179-6aa3a4ec2853',
    product_id: '1f2c8f19-22c1-43bb-bc8a-fa06313338d7',
    price_per_unit: 9.99,
    quantity: 500,
    manufactured_on: '2025-02-20',
    expiry_date: '2026-02-20',
  },
  {
    id: '237a3f91-735f-4d63-9b6e-6ab047c17e12',
    product_id: '22739a34-cf88-4331-8b50-dc0333e083a7',
    price_per_unit: 42.3,
    quantity: 80,
    manufactured_on: '2024-11-10',
    expiry_date: '2025-11-10',
  },
  {
    id: '7759d4b3-397b-47ea-bd0a-e9a3071df943',
    product_id: '260c5087-88a2-41bd-a892-ccc0db199b78',
    price_per_unit: 55.0,
    quantity: 120,
    manufactured_on: '2025-03-01',
    expiry_date: '2026-03-01',
  },
  {
    id: 'ce850fc5-1321-48a3-8ae4-f7dbb8c93cf2',
    product_id: '2bf4d5c0-74d9-450b-90cb-125864d96d8c',
    price_per_unit: 18.45,
    quantity: 300,
    manufactured_on: '2025-04-01',
    expiry_date: '2026-04-01',
  },
  {
    id: '47c26796-cba6-4bb9-81cb-7b5e7c99d457',
    product_id: '2dc41188-64b0-4b14-93de-f8121c774b88',
    price_per_unit: 22.2,
    quantity: 75,
    manufactured_on: '2025-01-01',
    expiry_date: '2025-12-31',
  },
  {
    id: '5fbd18c1-8634-4ea6-8b65-932b2e2c1181',
    product_id: '34799eb9-d699-4433-875b-a8bd4bc0a12a',
    price_per_unit: 30.0,
    quantity: 60,
    manufactured_on: '2025-01-10',
    expiry_date: '2026-01-10',
  },
  {
    id: 'f1e4ce00-7e1b-4b57-8250-3800cb4b8f6b',
    product_id: '34799eb9-d699-4433-875b-a8bd4bc0a12a',
    price_per_unit: 20.0,
    quantity: 90,
    manufactured_on: '2025-02-14',
    expiry_date: '2026-02-14',
  },
  {
    id: '0b4b7f9a-02b2-4b3c-b3b4-8f83f5fc67e4',
    product_id: '40cdf86b-e1f9-4a87-8c90-16554b251234',
    price_per_unit: 15.95,
    quantity: 150,
    manufactured_on: '2024-10-10',
    expiry_date: '2025-10-10',
  },
  {
    id: '75e1b725-cf2e-4744-b3ab-3b07d95fbd15',
    product_id: '40cdf86b-e1f9-4a87-8c90-16554b251234',
    price_per_unit: 17.99,
    quantity: 220,
    manufactured_on: '2025-06-01',
    expiry_date: '2026-06-01',
  },
  {
    id: 'c0d627fb-d70b-4622-b40a-144f1409ec50',
    product_id: '55a0ccbf-45fa-4965-a05e-b80590297fd7',
    price_per_unit: 12.0,
    quantity: 400,
    manufactured_on: '2025-02-20',
    expiry_date: '2026-02-20',
  },

  {
    id: 'df30de89-ec77-4148-8eec-c3ae6e649607',
    product_id: '55a0ccbf-45fa-4965-a05e-b80590297fd7',
    price_per_unit: 35.0,
    quantity: 45,
    manufactured_on: '2025-03-10',
    expiry_date: '2026-03-10',
  },
  {
    id: 'cb9e165e-ec6c-44b6-bae2-8f79c5ce3906',
    product_id: '6f5c70ed-991a-49ba-85c2-7ce8e7eed411',
    price_per_unit: 19.5,
    quantity: 130,
    manufactured_on: '2025-03-15',
    expiry_date: '2026-03-15',
  },
  {
    id: '1f165007-009f-4ce2-b7d7-70ac13c59e31',
    product_id: '775dad08-704f-4313-978c-3303b91f02f6',
    price_per_unit: 50.25,
    quantity: 55,
    manufactured_on: '2024-12-20',
    expiry_date: '2025-12-20',
  },
  {
    id: '1cc3c210-8a96-42eb-98e1-06bcb2a273a1',
    product_id: '7b9de6e2-9993-4011-b2a7-be51837a2f8c',
    price_per_unit: 11.11,
    quantity: 275,
    manufactured_on: '2025-05-01',
    expiry_date: '2026-05-01',
  },
  {
    id: '64d5c8d5-1217-4f42-8505-2a8e42fe1045',
    product_id: '8f1dc328-9d70-477e-840b-1b71ea6b5745',
    price_per_unit: 8.5,
    quantity: 340,
    manufactured_on: '2025-02-28',
    expiry_date: '2026-02-28',
  },
  {
    id: '39f1be0b-d825-466f-bbbc-1fe9e8fa5d95',
    product_id: '8620b9d9-2c8d-4309-a6dc-77d34d0d324c',
    price_per_unit: 26.99,
    quantity: 120,
    manufactured_on: '2025-06-12',
    expiry_date: '2026-06-12',
  },
  {
    id: 'b3a3eebc-5e14-49dc-bfbc-3a0613195a90',
    product_id: '8f1dc328-9d70-477e-840b-1b71ea6b5745',
    price_per_unit: 16.25,
    quantity: 210,
    manufactured_on: '2025-01-05',
    expiry_date: '2026-01-05',
  },
  {
    id: '8f3820f5-4d13-407b-87e2-3c1b51f79e6e',
    product_id: '92b39b56-3cf4-4237-bf24-c73eabc6857c',
    price_per_unit: 45.1,
    quantity: 60,
    manufactured_on: '2025-01-30',
    expiry_date: '2026-01-30',
  },
  {
    id: '45a1831c-e929-4a9c-bfd6-f6a6a1f2381c',
    product_id: '9352287f-8885-4d5e-8e9d-d7615841db79',
    price_per_unit: 23.0,
    quantity: 190,
    manufactured_on: '2024-11-25',
    expiry_date: '2025-11-25',
  },
  {
    id: '7b96c0b0-961f-4f0c-a1aa-d6e9a8f69a84',
    product_id: '9352287f-8885-4d5e-8e9d-d7615841db79',
    price_per_unit: 60.0,
    quantity: 100,
    manufactured_on: '2025-03-21',
    expiry_date: '2026-03-21',
  },
  {
    id: '10e77fa2-2542-481f-8ed8-362042ee4f55',
    product_id: '9f1f66d6-5b86-43d0-926b-3e31d3425889',
    price_per_unit: 18.0,
    quantity: 320,
    manufactured_on: '2025-04-10',
    expiry_date: '2026-04-10',
  },
  {
    id: 'ab03f403-7f78-4ae4-8b0f-1b806d6ab3fd',
    product_id: 'aa8e21b4-ee38-47e0-bd1b-18066ba43ff8',
    price_per_unit: 15.25,
    quantity: 370,
    manufactured_on: '2025-02-02',
    expiry_date: '2026-02-02',
  },
  {
    id: 'd2e6a18a-c68a-4092-a723-f08df613bffa',
    product_id: 'b241ac48-66aa-4092-a723-f8016d65fb19',
    price_per_unit: 33.3,
    quantity: 95,
    manufactured_on: '2025-03-03',
    expiry_date: '2026-03-03',
  },
  {
    id: '1d29a3f1-1c24-4f11-ae6f-88c7eee24add',
    product_id: 'd1337b33-f1cf-411e-acf6-88fc7eee24dd',
    price_per_unit: 21.45,
    quantity: 80,
    manufactured_on: '2024-12-12',
    expiry_date: '2025-12-12',
  },
  {
    id: '9eaa9a1e-e28a-4a16-a7fa-1882cbd62b97',
    product_id: 'e7d89463-b0cf-4669-8dd3-8bfe3b7c57a7',
    price_per_unit: 44.44,
    quantity: 170,
    manufactured_on: '2025-06-01',
    expiry_date: '2026-06-01',
  },
  {
    id: 'f3d05714-9386-442f-a0c4-c26f25aee891',
    product_id: 'e9f34e1e-422b-4a16-a178-94beed26e140',
    price_per_unit: 10.0,
    quantity: 500,
    manufactured_on: '2024-10-01',
    expiry_date: '2025-10-01',
  },
  {
    id: 'ea5b56a2-a27d-4f6f-b39d-4444e2bcc295',
    product_id: 'ea5b65a6-a27d-4f6f-b39d-444e2bcc2c95',
    price_per_unit: 17.1,
    quantity: 135,
    manufactured_on: '2025-05-05',
    expiry_date: '2026-05-05',
  },
  {
    id: 'ea26fc7a-5a07-46ce-bc65-b856605449f5',
    product_id: 'ee26fc7a-580f-4c6e-bc65-b8566054f9f5',
    price_per_unit: 27.27,
    quantity: 240,
    manufactured_on: '2025-03-03',
    expiry_date: '2026-03-03',
  },
  {
    id: 'f05dd99c-9ba9-4887-8f29-165b5ebab00c',
    product_id: 'f05dd99c-b9a8-4897-8f29-165b5ebab0cc',
    price_per_unit: 24.8,
    quantity: 110,
    manufactured_on: '2025-04-04',
    expiry_date: '2026-04-04',
  },
  {
    id: 'c6c66c13-fb8c-49c2-bd9e-360995235e1d',
    product_id: 'f94489e7-2454-42fd-98a6-2e561a72d62e',
    price_per_unit: 19.99,
    quantity: 190,
    manufactured_on: '2025-03-03',
    expiry_date: '2026-03-03',
  },
  {
    id: 'f94489e7-2454-4f2f-a625-5621a72d6e22',
    product_id: 'f94489e7-2454-42fd-98a6-2e561a72d62e',
    price_per_unit: 14.5,
    quantity: 180,
    manufactured_on: '2025-02-22',
    expiry_date: '2026-02-22',
  },
  {
    id: 'fba512cd-15db-42fe-b3de-8deb336576ed',
    product_id: 'fba521cd-15db-42fe-b3da-8deb336576ed',
    price_per_unit: 35.0,
    quantity: 200,
    manufactured_on: '2025-01-01',
    expiry_date: '2026-01-01',
  },
  {
    id: 'fe3d4804-099a-49e3-8d66-140f2e37d515',
    product_id: 'fe3d48d4-099a-49e3-86d6-140f2e37d515',
    price_per_unit: 38.88,
    quantity: 140,
    manufactured_on: '2025-05-05',
    expiry_date: '2026-05-05',
  },
];

async function seed() {
  try {
    await sequelize.authenticate();
    console.log('Database connected successfully.');

    // Sync the model without dropping existing data:
    await productBatch.sync();

    // Insert data:
    await productBatch.bulkCreate(productBatchData);

    console.log('Product Batches data inserted successfully.');

    await sequelize.close();
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}

seed();
