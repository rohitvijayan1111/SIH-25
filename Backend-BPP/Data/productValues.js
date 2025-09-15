// seedFarmers.js
// const sequelize = require('../config/sequelize'); // fix path if needed
const { DataTypes } = require('sequelize');
const sequelize = require('../config/sequelize');
const product = require('../model/product')(sequelize, DataTypes);
const products = [
  {
    id: '8620b9d9-2c8d-4309-a6dc-77d34d0d324c',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'NPK 19-19-19 Complex Fertilizer',
    type: 'fertilizer',
    unit: 'kg',
    price: 167,
    organic: false,
    description:
      'Balanced NPK fertilizer ideal for all crops during vegetative growth. Provides essential nutrients for healthy plant development.',
    image_url:
      'https://agribegri.com/productimage/9fe8297c45c97be54de92db321947346-08-16-23-19-07-56.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '7b9de6e2-9993-4011-b2a7-be51837a2f8c',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Organic Vermicompost',
    type: 'fertilizer',
    unit: 'kg',
    price: 234,
    organic: true,
    description:
      'Premium quality vermicompost enriched with beneficial microorganisms. Improves soil structure and nutrient availability naturally.',
    image_url:
      'https://www.jiomart.com/images/product/original/rvzuopky2f/natural-earth-1-kg-pure-premium-organic-vermicompost-fertilizer-suitable-for-all-types-of-plants-product-images-orvzuopky2f-p606095401-0-202401202353.jpg?im=Resize=(1000,1000)',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '9ba275dc-6b4f-4e08-873c-2fbfa64385e7',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Urea 46% Nitrogen',
    type: 'fertilizer',
    unit: 'bag',
    price: 140,
    organic: false,
    description:
      'High nitrogen content fertilizer for rapid vegetative growth. Suitable for cereals, sugarcane, and leafy vegetables.',
    image_url:
      'https://images-cdn.ubuy.co.in/644ec2cda358b153ad3b22e8-urea-fertilizer-46-0-0-made-in-usa-plant.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '9352287f-8885-4d5e-8e9d-d7615841db79',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'DAP (Diammonium Phosphate)',
    type: 'fertilizer',
    unit: 'bag',
    price: 470,
    organic: false,
    description:
      'Phosphorus-rich fertilizer perfect for root development and flowering. Essential for fruit and grain formation.',
    image_url:
      'https://risso-chemical.com/wp-content/uploads/2024/08/DAP-Diammonium-Phosphate.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'fba521cd-15db-42fe-b3da-8deb336576ed',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Potash (Muriate of Potash)',
    type: 'fertilizer',
    unit: 'kg',
    price: 74,
    organic: false,
    description:
      'Potassium-rich fertilizer for improved fruit quality and disease resistance. Enhances water regulation in plants.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT5tjh1mTF5cdBJ9AscQwgSwMlsGJetxGzBTg&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '1a51ceef-95f3-4817-a239-213f315cf04e',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Bone Meal Organic Fertilizer',
    type: 'fertilizer',
    unit: 'kg',
    price: 466,
    organic: true,
    description:
      'Slow-release organic phosphorus fertilizer made from processed animal bones. Excellent for flowering and fruiting plants.',
    image_url: 'https://m.media-amazon.com/images/I/611f-p12F8L.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'fe3d48d4-099a-49e3-86d6-140f2e37d515',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Liquid Seaweed Extract',
    type: 'fertilizer',
    unit: 'liter',
    price: 390,
    organic: true,
    description:
      'Concentrated liquid fertilizer rich in trace elements and natural growth hormones. Promotes healthy root and shoot development.',
    image_url:
      'https://organicbazar.net/cdn/shop/products/Liquid-Seaweed-Concentrate-Fertilizer-for-Plants.jpg?v=1694169201',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '1f2c8f19-22c1-43bb-bc8a-fa06313338d7',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Copper Oxychloride 50% WP',
    type: 'fungicide',
    unit: 'kg',
    price: 267,
    organic: false,
    description:
      'Broad-spectrum fungicide effective against blight, rust, and mildew. Suitable for vegetables, fruits, and ornamental plants.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTX4Na5c_Cqeb5YtTZanKmKKC0_Qgi7SO4zqw&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'ee26fc7a-580f-4c6e-bc65-b8566054f9f5',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Trichoderma Viride Bio-Fungicide',
    type: 'fungicide',
    unit: 'kg',
    price: 403,
    organic: true,
    description:
      'Biological fungicide containing beneficial Trichoderma fungi. Controls soil-borne pathogens and promotes plant health naturally.',
    image_url:
      'https://www.katyayaniorganics.com/wp-content/uploads/2022/06/Tyson-Bottle_11zon.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'e7d89463-b0cf-4669-8dd3-8bfe3b7c57a7',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Carbendazim 50% WP',
    type: 'fungicide',
    unit: 'kg',
    price: 81,
    organic: false,
    description:
      'Systemic fungicide for control of various fungal diseases in cereals, pulses, and horticultural crops.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_bge_Isy4UruEdKLt_IhhXATT1U47sFiDhA&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'ea5b65a6-a27d-4f6f-b39d-444e2bcc2c95',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Mancozeb 75% WP',
    type: 'fungicide',
    unit: 'kg',
    price: 342,
    organic: false,
    description:
      'Protective fungicide with broad-spectrum activity against leaf spot, blight, and downy mildew in various crops.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS_bge_Isy4UruEdKLt_IhhXATT1U47sFiDhA&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '6f5c70ed-991a-49ba-85c2-7ce8e7eed411',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Neem Oil Concentrate',
    type: 'fungicide',
    unit: 'liter',
    price: 87,
    organic: true,
    description:
      'Organic fungicide extracted from neem seeds. Effective against powdery mildew, rust, and other fungal diseases.',
    image_url: 'https://m.media-amazon.com/images/I/71HBharDb-L.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '2bf4d5c0-74d9-450b-90cb-125864d96d8c',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Bordeaux Mixture',
    type: 'fungicide',
    unit: 'kg',
    price: 399,
    organic: false,
    description:
      'Traditional copper-based fungicide for control of bacterial and fungal diseases in fruit trees and vegetables.',
    image_url:
      'https://www.katyayaniorganics.com/wp-content/uploads/2023/10/Disease-Collection-Images-16_11zon.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '92b39b56-3cf4-4237-bf24-c73eabc6857c',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Propiconazole 25% EC',
    type: 'fungicide',
    unit: 'liter',
    price: 88,
    organic: false,
    description:
      'Systemic fungicide for control of leaf spots, rusts, and powdery mildew in cereals and horticultural crops.',
    image_url: 'https://agribegri.com/productimage/21365174551718884299.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '22739a34-cf88-4331-8b50-dc0333e083a7',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Humic Acid Granules',
    type: 'growth_promoter',
    unit: 'kg',
    price: 81,
    organic: true,
    description:
      'Organic soil conditioner that improves nutrient uptake and root development. Enhances soil structure and water retention.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7YOKyKLE92eeT0x39X6WDpavIvCpEmR39tA&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '59d15dc1-0999-4f9c-a851-ab805ebbfc24',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Amino Acid Liquid Fertilizer',
    type: 'growth_promoter',
    unit: 'liter',
    price: 87,
    organic: true,
    description:
      'Organic growth promoter containing essential amino acids. Boosts plant metabolism and stress resistance.',
    image_url: 'https://m.media-amazon.com/images/I/61VcherjuKL.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '8f1dc328-9d70-477e-840b-1b71ea6b5745',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Mycorrhizal Inoculant',
    type: 'growth_promoter',
    unit: 'kg',
    price: 107,
    organic: true,
    description:
      'Beneficial fungi that form symbiotic relationships with plant roots. Improves nutrient and water uptake efficiency.',
    image_url:
      'https://www.dynomyco.com/cdn/shop/files/amazon-product-image-pouch750g.jpg?v=1730209078',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '9f81a640-80a5-4429-b4fa-37e1dfe73571',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Kelp Meal Organic Booster',
    type: 'growth_promoter',
    unit: 'kg',
    price: 166,
    organic: true,
    description:
      'Dried seaweed meal rich in natural growth hormones and micronutrients. Promotes vigorous plant growth and flowering.',
    image_url:
      'https://m.media-amazon.com/images/I/71BhhVCJgdL._UF1000,1000_QL80_.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'e9f34e1e-422b-4a16-a178-94beed26e140',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Gibberellic Acid Solution',
    type: 'growth_promoter',
    unit: 'liter',
    price: 326,
    organic: false,
    description:
      'Plant growth regulator for stem elongation and flower initiation. Increases fruit size and improves crop uniformity.',
    image_url:
      'https://parijatagrochemicals.com/wp-content/uploads/2016/10/GIBAC.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'd1337b33-f1cf-411e-acf6-88fc7eee24dd',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Bio-Stimulant Complex',
    type: 'growth_promoter',
    unit: 'liter',
    price: 184,
    organic: true,
    description:
      'Organic blend of plant extracts and beneficial microorganisms. Enhances root development and stress tolerance.',
    image_url:
      'https://agribegri.com/productimage/1c7bee819b9d753797d1710ea9214bed-01-04-24-15-15-06.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '9f1f66d6-5b86-43d0-926b-3e31d3425889',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'NAA (Naphthaleneacetic Acid)',
    type: 'growth_regulator',
    unit: 'gm',
    price_per_unit: 370,
    organic: 'f',
    description:
      'Root promoting hormone for cutting propagation and transplant establishment. Accelerates root formation in various plants.',
    image_url:
      'https://plantcelltechnology.com/cdn/shop/files/NAA-liquid_strong.png?v=1717548203&width=1445',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '40cdf86b-e1f9-4a87-8c90-16554b251234',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Cytokinins Plant Hormone',
    type: 'growth_regulator',
    unit: 'liter',
    price_per_unit: 57,
    organic: 'f',
    description:
      'Cell division promoting hormone for tissue culture and fruit development. Delays senescence and promotes lateral growth.',
    image_url:
      'https://greenok.lv/wp-content/uploads/2019/07/Cytokinin-Hobby-x2-1k.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '260c5087-88a2-41bd-a892-ccc0db199b78',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Ethephon 39% SL',
    type: 'growth_regulator',
    unit: 'liter',
    price_per_unit: 222,
    organic: 'f',
    description:
      'Ethylene-releasing compound for fruit ripening and flower induction. Used in pineapple, tomato, and mango cultivation.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnewwQ1HRliHX2w7se35cZ8-JxBR0EDEOOYA&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'f94489e7-2454-42fd-98a6-2e561a72d62e',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Paclobutrazol 23% SC',
    type: 'growth_regulator',
    unit: 'liter',
    price_per_unit: 339,
    organic: 'f',
    description:
      'Plant growth retardant for controlling excessive vegetative growth. Promotes flowering and fruiting in ornamental plants.',
    image_url:
      'https://www.katyayaniorganics.com/wp-content/uploads/2022/06/FAST_resize.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'aa8e21b4-ee38-47e0-bd1b-18066ba43ff8',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'IBA (Indole Butyric Acid)',
    type: 'growth_regulator',
    unit: 'gm',
    price_per_unit: 189,
    organic: 'f',
    description:
      'Auxin-type hormone for root initiation in cuttings. Essential for nursery operations and plant propagation.',
    image_url:
      'https://www.himedialabs.com/media/catalog/product/cache/877ab4ac479bafc7781763a993c9e527/r/m/rm384-25g_1.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '4e1e6b58-cce0-4217-8d9c-43eb0250ec6d',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: '2,4-D Sodium Salt',
    type: 'growth_regulator',
    unit: 'kg',
    price_per_unit: 478,
    organic: 'f',
    description:
      'Synthetic auxin for callus induction and fruit development. Used in tissue culture and parthenocarpic fruit production.',
    image_url:
      'https://4.imimg.com/data4/OB/EO/MY-2629372/2-4-d-sodium-salt-80-wp.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '1c704464-1549-4253-b9c8-a0ef7a19e2ba',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Triacontanol Growth Enhancer',
    type: 'growth_regulator',
    unit: 'liter',
    price_per_unit: 212,
    organic: 't',
    description:
      'Natural plant growth regulator derived from plant waxes. Increases photosynthetic efficiency and crop yield.',
    image_url:
      'https://chowdhuryfertilizer.in/images/product-images/1611321254546615763.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '34799eb9-d699-4433-875b-a8bd4bc0a12a',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Glyphosate 41% SL',
    type: 'herbicide',
    unit: 'liter',
    price_per_unit: 284,
    organic: 'f',
    description:
      'Non-selective systemic herbicide for broad-spectrum weed control. Effective against annual and perennial weeds.',
    image_url: 'https://agribegri.com/productimage/7354035311733221089.webp',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '775dad08-704f-4313-978c-3303b91f02f6',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Paraquat 24% SL',
    type: 'herbicide',
    unit: 'liter',
    price_per_unit: 126,
    organic: 'f',
    description:
      'Fast-acting contact herbicide for quick weed burn-down. Ideal for pre-planting weed control in various crops.',
    image_url:
      'https://parijatagrochemicals.com/wp-content/uploads/2017/09/PARIQUAT.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '2dc41188-64b0-4b14-93de-f8121c774b88',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Corn Gluten Meal',
    type: 'herbicide',
    unit: 'kg',
    price_per_unit: 280,
    organic: 't',
    description:
      'Organic pre-emergent herbicide that prevents weed seed germination. Safe for established plants and beneficial insects.',
    image_url: 'https://www.gulshanindia.com/images/corn_gulten_side.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'f05dd99c-b9a8-4897-8f29-165b5ebab0cc',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Atrazine 50% WP',
    type: 'herbicide',
    unit: 'kg',
    price_per_unit: 274,
    organic: 'f',
    description:
      'Selective herbicide for maize and sugarcane crops. Controls grasses and broadleaf weeds effectively.',
    image_url:
      'https://agriplexindia.com/cdn/shop/files/Ju-Atrazine50-Wdp.png?v=1743241311',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'b241ac48-66aa-4092-a723-f8016d65fb19',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Vinegar-Based Herbicide',
    type: 'herbicide',
    unit: 'liter',
    price_per_unit: 264,
    organic: 't',
    description:
      'Organic herbicide made from concentrated acetic acid. Effective against young weeds and safe for organic farming.',
    image_url:
      'https://images-cdn.ubuy.co.in/64705e141e39f20e655f3f91-green-gobbler-20-vinegar-weed-grass.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '55a0ccbf-45fa-4965-a05e-b80590297fd7',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Pendimethalin 30% EC',
    type: 'herbicide',
    unit: 'liter',
    price_per_unit: 305,
    organic: 'f',
    description:
      'Pre-emergent herbicide for weed control in wheat, rice, and vegetable crops. Prevents germination of grass weeds.',
    image_url:
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPJfVg6rCrGH1VpwVIN-5zJp6PMYWKzr9-wQ&s',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'f6de84c0-a11c-43e1-b1e3-360995233635',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Mulch Film Roll',
    type: 'herbicide',
    unit: 'roll',
    price_per_unit: 268,
    organic: 't',
    description:
      'Biodegradable plastic mulch for weed suppression and moisture retention. Eco-friendly alternative to chemical herbicides.',
    image_url:
      'https://cdn.shopify.com/s/files/1/0722/2059/files/iris-polymer-mulch-film-file-10938.jpg?v=1737444877',
    created_at: '2025-07-05 09:05:47+05:30',
  },

  //Seeds
  {
    id: 'a1b2c3d4-e5f6-7890-abcd-ef1234567890',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Hybrid Corn Seed',
    type: 'seed',
    unit: 'kg',
    organic: false,
    description: 'High-yield hybrid corn seed suitable for various climates.',
    image_url: 'https://example.com/images/hybrid-corn-seed.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'f1e2d3c4-b5a6-7890-fedc-ba9876543210',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Organic Tomato Seeds',
    type: 'seed',
    unit: 'packet',
    organic: true,
    description:
      'Certified organic tomato seeds for garden and greenhouse cultivation.',
    image_url: 'https://example.com/images/organic-tomato-seeds.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'e9f7d1ef-6cb5-4ce3-a167-ee657c90a822',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Basmati Rice Paddy Seeds',
    type: 'seed',
    unit: 'kg',
    organic: false,
    description: 'Premium paddy seeds with high grain quality and yield.',
    image_url: 'https://example.com/images/basmati-rice-seed.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'deca4e55-53a1-4fcb-b4b5-b88c75aa12da',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Okra Seeds',
    type: 'seed',
    unit: 'packet',
    organic: false,
    description: 'High yielding okra seeds, disease resistant variety.',
    image_url: 'https://example.com/images/okra-seeds.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'bcf3e7df-de42-42c7-838e-22e607954fd3',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Hybrid Sunflower Seeds',
    type: 'seed',
    unit: 'kg',
    organic: false,
    description: 'High oil content sunflower seeds for commercial cultivation.',
    image_url: 'https://example.com/images/hybrid-sunflower-seeds.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '452dcd34-d277-434b-bbc1-39a0a9bc6a29',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Spinach Seeds',
    type: 'seed',
    unit: 'packet',
    organic: true,
    description: 'Fast-growing spinach seeds rich in vitamins and minerals.',
    image_url: 'https://example.com/images/spinach-seeds.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },

  //micronutrients
  {
    id: 'd4c3b2a1-e6f5-0987-dcba-fe6543210987',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Zinc Sulphate',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: false,
    description: 'Essential for enzyme activation and healthy plant growth.',
    image_url:
      'https://www.agrifert.com.my/wp-content/uploads/2020/03/ZincSulphate.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'c839ff45-9271-46ca-9831-34cb4b053b2d',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Copper Chelate',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: false,
    description: 'Improves plant metabolism and disease resistance.',
    image_url:
      'https://www.gubbagroup.com/admin/assets/product/Copper-Chelate-EDTA-372.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '85be0df2-2115-4b66-ad76-403f7625c83b',
    farmer_id: '910d34a9-b9c0-489a-b7e1-73657d0e4503',
    name: 'Iron EDTA',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: false,
    description: 'Prevents chlorosis and ensures lush, green foliage.',
    image_url: 'https://www.balajiagro.com/image/Fe-EDTA-12.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: 'b0e027d2-9d82-4181-9790-d7a2fcdb2b22',
    farmer_id: '690c54df-470f-4508-89de-db2648d7d260',
    name: 'Manganese Sulphate',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: false,
    description: 'Aids in photosynthesis and overall plant vigor.',
    image_url:
      'https://cdn11.bigcommerce.com/s-qnz5l7b/images/stencil/1280x1280/products/344/530/ManganeseSulphate__47421.1501182822.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '4a3853b2-6e64-45ae-963b-6ee458b6a31c',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Magnesium Chelate',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: false,
    description: 'Promotes chlorophyll production and crop yield.',
    image_url:
      'https://www.plantnutrition.in/admin/assets/product/large/magnesium%20edta%20.jpg',
    created_at: '2025-07-05 09:05:47+05:30',
  },
  {
    id: '2ce93c67-ae7a-4736-9872-97142a2b1fbd',
    farmer_id: 'dbd62bb4-618d-454a-9a90-523317ab3734',
    name: 'Boronated Micronutrient Mix',
    type: 'micro_nutrient',
    unit: 'kg',
    organic: true,
    description: 'Boron-rich formula for flowering and fruit setting.',
    image_url:
      'https://www.iffco.in/images/articleImages/boron_logo1600931816.png',
    created_at: '2025-07-05 09:05:47+05:30',
  },
];

async function seed() {
  try {
    await sequelize.authenticate();
    console.log('Database connected successfully.');

    // Sync the model without dropping existing data:
    await product.sync();

    // Insert data:
    await product.bulkCreate(products);

    console.log('Product data inserted successfully.');

    await sequelize.close();
  } catch (error) {
    console.error('Error seeding data:', error);
  }
}

seed();
