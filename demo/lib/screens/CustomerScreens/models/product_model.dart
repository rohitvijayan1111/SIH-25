class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
  final String farmerName;
  final bool isFavorite;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.description = '',
    this.farmerName = '',
    this.isFavorite = false,
  });

  // Create a copy of product with updated favorite status
  Product copyWith({bool? isFavorite}) {
    return Product(
      id: id,
      name: name,
      price: price,
      imageUrl: imageUrl,
      category: category,
      description: description,
      farmerName: farmerName,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

// Sample data for demonstration
class ProductData {
  static List<Product> getAllServices() {
    return [
      // 🌱 Herbicide
      Product(
        id: 'H1',
        name: 'Glyphosate',
        price: '350',
        imageUrl:
            'https://images.unsplash.com/photo-1606788075761-47ec6b87e4e2?w=400',
        category: 'Herbicide',
        description: 'Broad-spectrum systemic herbicide for weed control',
        farmerName: 'AgroChem Pvt Ltd',
      ),
      Product(
        id: 'H2',
        name: 'Paraquat',
        price: '280',
        imageUrl:
            'https://images.unsplash.com/photo-1615485295343-d6b89d6e9c94?w=400',
        category: 'Herbicide',
        description: 'Fast-acting herbicide for non-selective weed removal',
        farmerName: 'GreenGrow Solutions',
      ),
      Product(
        id: 'H3',
        name: '2,4-D Amine Salt',
        price: '300',
        imageUrl:
            'https://images.unsplash.com/photo-1587574293443-d490e1f6c3f2?w=400',
        category: 'Herbicide',
        description: 'Selective weed killer for cereal crops',
        farmerName: 'FarmWell',
      ),
      Product(
        id: 'H4',
        name: 'Atrazine',
        price: '270',
        imageUrl:
            'https://images.unsplash.com/photo-1620419387229-c02d5ad01f19?w=400',
        category: 'Herbicide',
        description: 'Pre- and post-emergence herbicide for maize & sugarcane',
        farmerName: 'CropCare Agro',
      ),
      Product(
        id: 'H5',
        name: 'Pendimethalin',
        price: '320',
        imageUrl:
            'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=400',
        category: 'Herbicide',
        description: 'Pre-emergent herbicide effective for grasses and weeds',
        farmerName: 'Farmer Supply Co',
      ),

      // 🌿 Growth Regulators
      Product(
        id: 'GR1',
        name: 'Gibberellic Acid',
        price: '150',
        imageUrl:
            'https://images.unsplash.com/photo-1524592094714-0f0654e20314?w=400',
        category: 'Growth Regulators',
        description: 'Stimulates stem elongation and seed germination',
        farmerName: 'BioAgro Labs',
      ),
      Product(
        id: 'GR2',
        name: 'Cytokinin Spray',
        price: '180',
        imageUrl:
            'https://images.unsplash.com/photo-1549887534-6ec093d1f1d5?w=400',
        category: 'Growth Regulators',
        description: 'Promotes cell division and leaf expansion',
        farmerName: 'AgriBioTech',
      ),
      Product(
        id: 'GR3',
        name: 'Ethrel',
        price: '200',
        imageUrl:
            'https://images.unsplash.com/photo-1560807707-8cc77767d783?w=400',
        category: 'Growth Regulators',
        description: 'Regulates fruit ripening and flower induction',
        farmerName: 'FarmChem India',
      ),
      Product(
        id: 'GR4',
        name: 'Naphthalene Acetic Acid (NAA)',
        price: '170',
        imageUrl:
            'https://images.unsplash.com/photo-1524594154908-edd53b92f46c?w=400',
        category: 'Growth Regulators',
        description: 'Helps in root initiation and fruit thinning',
        farmerName: 'AgroLife Sciences',
      ),
      Product(
        id: 'GR5',
        name: 'Paclobutrazol',
        price: '220',
        imageUrl:
            'https://images.unsplash.com/photo-1597911319255-bf1e963c7f3f?w=400',
        category: 'Growth Regulators',
        description: 'Plant growth retardant for uniform flowering',
        farmerName: 'GrowTech Agro',
      ),

      // 🍄 Fungicide
      Product(
        id: 'F1',
        name: 'Mancozeb',
        price: '250',
        imageUrl:
            'https://images.unsplash.com/photo-1625241649684-d7c571a35cb1?w=400',
        category: 'Fungicide',
        description: 'Broad-spectrum fungicide for fruits and vegetables',
        farmerName: 'SafeCrop Ltd',
      ),
      Product(
        id: 'F2',
        name: 'Carbendazim',
        price: '200',
        imageUrl:
            'https://images.unsplash.com/photo-1576862045971-1f1fd41cf2ab?w=400',
        category: 'Fungicide',
        description: 'Systemic fungicide effective against seed-borne diseases',
        farmerName: 'BioCrop Care',
      ),
      Product(
        id: 'F3',
        name: 'Copper Oxychloride',
        price: '220',
        imageUrl:
            'https://images.unsplash.com/photo-1594984824727-5c5af6a6c82f?w=400',
        category: 'Fungicide',
        description: 'Contact fungicide for vegetables and fruits',
        farmerName: 'AgriGuard',
      ),
      Product(
        id: 'F4',
        name: 'Sulphur Dust',
        price: '180',
        imageUrl:
            'https://images.unsplash.com/photo-1514933651103-005eec06c04b?w=400',
        category: 'Fungicide',
        description: 'Effective for powdery mildew control',
        farmerName: 'AgroSafe',
      ),
      Product(
        id: 'F5',
        name: 'Hexaconazole',
        price: '300',
        imageUrl:
            'https://images.unsplash.com/photo-1615484477652-f58ae0c2f9c0?w=400',
        category: 'Fungicide',
        description: 'Systemic fungicide for rice and groundnut crops',
        farmerName: 'GreenCrop Agro',
      ),

      // 🌱 Growth Promoter
      Product(
        id: 'GP1',
        name: 'Seaweed Extract',
        price: '280',
        imageUrl:
            'https://images.unsplash.com/photo-1615474025265-cfbcfa31d0dd?w=400',
        category: 'Growth Promoter',
        description: 'Natural plant growth promoter',
        farmerName: 'BioGrow Organics',
      ),
      Product(
        id: 'GP2',
        name: 'Humic Acid',
        price: '240',
        imageUrl:
            'https://images.unsplash.com/photo-1599474920788-3fcb7d5005ef?w=400',
        category: 'Growth Promoter',
        description: 'Improves soil fertility and root growth',
        farmerName: 'EcoFarm Solutions',
      ),
      Product(
        id: 'GP3',
        name: 'Amino Acid Spray',
        price: '300',
        imageUrl:
            'https://images.unsplash.com/photo-1581090700227-4c4f50f81537?w=400',
        category: 'Growth Promoter',
        description: 'Enhances nutrient uptake and stress tolerance',
        farmerName: 'AgroBoost',
      ),
      Product(
        id: 'GP4',
        name: 'Organic Compost Tea',
        price: '200',
        imageUrl:
            'https://images.unsplash.com/photo-1612036782181-dbb6cbf8c4b8?w=400',
        category: 'Growth Promoter',
        description: 'Boosts microbial activity in soil',
        farmerName: 'FarmPure',
      ),
      Product(
        id: 'GP5',
        name: 'Silicon Spray',
        price: '260',
        imageUrl:
            'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=400',
        category: 'Growth Promoter',
        description: 'Improves plant resistance against stress',
        farmerName: 'CropShield',
      ),

      // 🌾 Fertilizer
      Product(
        id: 'FT1',
        name: 'Urea',
        price: '550',
        imageUrl:
            'https://images.unsplash.com/photo-1615485292530-ebaec1adebdd?w=400',
        category: 'Fertilizer',
        description: 'Nitrogen-based fertilizer for all crops',
        farmerName: 'AgriInput Suppliers',
      ),
      Product(
        id: 'FT2',
        name: 'DAP (Diammonium Phosphate)',
        price: '1200',
        imageUrl:
            'https://images.unsplash.com/photo-1620419387349-21b08eb7cbe0?w=400',
        category: 'Fertilizer',
        description: 'Source of phosphorus and nitrogen',
        farmerName: 'CropCare Inputs',
      ),
      Product(
        id: 'FT3',
        name: 'MOP (Muriate of Potash)',
        price: '1000',
        imageUrl:
            'https://images.unsplash.com/photo-1507915135761-41a0a222c709?w=400',
        category: 'Fertilizer',
        description: 'Potassium-rich fertilizer for crop growth',
        farmerName: 'Kisan Agro',
      ),
      Product(
        id: 'FT4',
        name: 'Ammonium Sulphate',
        price: '900',
        imageUrl:
            'https://images.unsplash.com/photo-1598618435460-6c0e2e6f9ed1?w=400',
        category: 'Fertilizer',
        description: 'Nitrogen and sulphur source',
        farmerName: 'FarmChem Industries',
      ),
      Product(
        id: 'FT5',
        name: 'Organic Manure',
        price: '400',
        imageUrl:
            'https://images.unsplash.com/photo-1600508774768-f3ec5e5b2ff4?w=400',
        category: 'Fertilizer',
        description: 'Eco-friendly soil enhancer',
        farmerName: 'EcoGrow Farms',
      ),

      // ⚡ Micro Nutrient
      Product(
        id: 'MN1',
        name: 'Zinc Sulphate',
        price: '350',
        imageUrl:
            'https://images.unsplash.com/photo-1620403726161-52dfd74d30a7?w=400',
        category: 'Micro Nutrient',
        description: 'Corrects zinc deficiency in crops',
        farmerName: 'MicroGrow',
      ),
      Product(
        id: 'MN2',
        name: 'Boron Spray',
        price: '280',
        imageUrl:
            'https://images.unsplash.com/photo-1615474025145-5fda87f7e76f?w=400',
        category: 'Micro Nutrient',
        description: 'Enhances fruit and seed development',
        farmerName: 'NutriCrop',
      ),
      Product(
        id: 'MN3',
        name: 'Ferrous Sulphate',
        price: '260',
        imageUrl:
            'https://images.unsplash.com/photo-1620421682185-cbc6f4a62fd7?w=400',
        category: 'Micro Nutrient',
        description: 'Treats iron deficiency chlorosis',
        farmerName: 'AgriNutra',
      ),
      Product(
        id: 'MN4',
        name: 'Manganese Sulphate',
        price: '270',
        imageUrl:
            'https://images.unsplash.com/photo-1615474025070-807c75ca8dcf?w=400',
        category: 'Micro Nutrient',
        description: 'Essential for enzyme activity in plants',
        farmerName: 'CropBalance',
      ),
      Product(
        id: 'MN5',
        name: 'Copper Sulphate',
        price: '290',
        imageUrl:
            'https://images.unsplash.com/photo-1620419387191-4c90dfd5d1b7?w=400',
        category: 'Micro Nutrient',
        description: 'Improves plant metabolism',
        farmerName: 'AgriMicro',
      ),

      // 🌱 Seeds
      Product(
        id: 'S1',
        name: 'Hybrid Maize Seeds',
        price: '800',
        imageUrl:
            'https://images.unsplash.com/photo-1604999339201-dc6f6e8b68ff?w=400',
        category: 'Seeds',
        description: 'High-yielding hybrid maize variety',
        farmerName: 'SeedWorld',
      ),
      Product(
        id: 'S2',
        name: 'Paddy Seeds',
        price: '900',
        imageUrl:
            'https://images.unsplash.com/photo-1620421397732-791f2d4f49c2?w=400',
        category: 'Seeds',
        description: 'Quality rice seeds for better yield',
        farmerName: 'Kisan Seeds',
      ),
      Product(
        id: 'S3',
        name: 'Vegetable Seeds Pack',
        price: '600',
        imageUrl:
            'https://images.unsplash.com/photo-1598618411618-9b65f1dc80bd?w=400',
        category: 'Seeds',
        description: 'Mix of tomato, chili, and okra seeds',
        farmerName: 'AgriSeed Co',
      ),
      Product(
        id: 'S4',
        name: 'Wheat Seeds',
        price: '750',
        imageUrl:
            'https://images.unsplash.com/photo-1501004318641-b39e6451bec6?w=400',
        category: 'Seeds',
        description: 'Improved wheat seed variety',
        farmerName: 'GrainSeed Corp',
      ),
      Product(
        id: 'S5',
        name: 'Cotton Seeds',
        price: '950',
        imageUrl:
            'https://images.unsplash.com/photo-1620419387249-5eb381fceab9?w=400',
        category: 'Seeds',
        description: 'BT cotton seeds for high yield',
        farmerName: 'AgroSeed India',
      ),

      // 🏞️ Land Lease & Sale
      Product(
        id: 'LL1',
        name: '2 Acre Fertile Land - Lease',
        price: '50000',
        imageUrl:
            'https://images.unsplash.com/photo-1500530855697-b586d89ba3ee?w=400',
        category: 'Land Lease & Sale',
        description: 'Well-irrigated land suitable for vegetables',
        farmerName: 'Farmer Prakash',
      ),
      Product(
        id: 'LL2',
        name: '5 Acre Paddy Land - Sale',
        price: '1200000',
        imageUrl:
            'https://images.unsplash.com/photo-1604335399103-fad3e4a9ccab?w=400',
        category: 'Land Lease & Sale',
        description: 'Prime land with water source',
        farmerName: 'Farmer Suresh',
      ),
      Product(
        id: 'LL3',
        name: '3 Acre Orchard Land - Lease',
        price: '70000',
        imageUrl:
            'https://images.unsplash.com/photo-1589927986089-35812388d1b3?w=400',
        category: 'Land Lease & Sale',
        description: 'Land suited for mango & guava orchards',
        farmerName: 'Farmer Radha',
      ),
      Product(
        id: 'LL4',
        name: '10 Acre Farmland - Sale',
        price: '2500000',
        imageUrl:
            'https://images.unsplash.com/photo-1598618458882-3a799af5d5a2?w=400',
        category: 'Land Lease & Sale',
        description: 'Irrigated fertile soil, ideal for cash crops',
        farmerName: 'Farmer Nanda',
      ),
      Product(
        id: 'LL5',
        name: '1 Acre Vegetable Plot - Lease',
        price: '30000',
        imageUrl:
            'https://images.unsplash.com/photo-1594984990978-98f50f9c1926?w=400',
        category: 'Land Lease & Sale',
        description: 'Small plot for seasonal vegetables',
        farmerName: 'Farmer Rekha',
      ),
    ];
  }

  static List<String> getServiceCategories() {
    return [
      'Herbicide',
      'Growth Regulators',
      'Fungicide',
      'Growth Promoter',
      'Fertilizer',
      'Micro Nutrient',
      'Seeds',
      'Land Lease & Sale',
    ];
  }

  static List<Product> getAllProducts() {
    return [
      const Product(
        id: '1',
        name: 'Broccoli',
        price: '120',
        imageUrl:
            'https://images.unsplash.com/photo-1459411621453-7b03977f4bfc?w=400',
        category: 'Vegetables',
        description: 'Fresh green broccoli from local farms',
        farmerName: 'Farmer John',
        isFavorite: true,
      ),
      const Product(
        id: '2',
        name: 'Papaya',
        price: '80',
        imageUrl: 'assets/CustomerUIAssets/images/papaya.jpg',
        category: 'Fruits',
        description: 'Sweet and juicy papaya',
        farmerName: 'Farmer Mary',
        isFavorite: false,
      ),
      const Product(
        id: '3',
        name: 'Tomatoes',
        price: '60',
        imageUrl: 'assets/CustomerUIAssets/images/tomato.jpg',
        category: 'Vegetables',
        description: 'Red ripe tomatoes',
        farmerName: 'Farmer Bob',
        isFavorite: false,
      ),
      const Product(
        id: '4',
        name: 'Carrots',
        price: '45',
        imageUrl:
            'https://images.unsplash.com/photo-1447175008436-054170c2e979?w=400',
        category: 'Vegetables',
        description: 'Orange fresh carrots',
        farmerName: 'Farmer Alice',
        isFavorite: true,
      ),
      const Product(
        id: '6',
        name: 'Banana',
        price: '30',
        imageUrl: 'assets/CustomerUIAssets/images/banana.jpg',
        category: 'Fruits',
        description: 'Fresh bananas, source of potassium',
        farmerName: 'Farmer Kumar',
        isFavorite: false,
      ),

      const Product(
        id: '8',
        name: 'Wheat',
        price: '25',
        imageUrl: 'assets/CustomerUIAssets/images/wheat.jpg',
        category: 'Grains',
        description: 'High-quality wheat grains',
        farmerName: 'Farmer Ramesh',
        isFavorite: false,
      ),
      const Product(
        id: '9',
        name: 'Rice',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/rice.jpg',
        category: 'Grains',
        description: 'Premium basmati rice',
        farmerName: 'Farmer Devi',
        isFavorite: true,
      ),
      const Product(
        id: '10',
        name: 'Maize',
        price: '32',
        imageUrl: 'assets/CustomerUIAssets/images/maize.jpg',
        category: 'Grains',
        description: 'Fresh maize from the farm',
        farmerName: 'Farmer Mohan',
        isFavorite: false,
      ),
      // Dairy
      const Product(
        id: '11',
        name: 'Milk',
        price: '52',
        imageUrl: 'assets/CustomerUIAssets/images/milk.jpg',
        category: 'Dairy',
        description: 'Fresh cow milk delivered daily',
        farmerName: 'Dairy Farmhouse',
        isFavorite: true,
      ),
      const Product(
        id: '12',
        name: 'Paneer',
        price: '210',
        imageUrl: 'assets/CustomerUIAssets/images/paneer.jpg',
        category: 'Dairy',
        description: 'Soft cottage cheese, homemade',
        farmerName: 'Farmer Shanti',
      ),
      const Product(
        id: '13',
        name: 'Curd',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/curd.jpg',
        category: 'Dairy',
        description: 'Thick curd from desi cows',
        farmerName: 'Farmer Anil',
        isFavorite: true,
      ),
      const Product(
        id: '14',
        name: 'Butter',
        price: '380',
        imageUrl: 'assets/CustomerUIAssets/images/butter.webp',
        category: 'Dairy',
        description: 'Freshly churned yellow butter',
        farmerName: 'Dairy Collective',
        isFavorite: true,
      ),
    ];
  }

  static List<String> getCategories() {
    return ['All', 'Vegetables', 'Fruits', 'Grains', 'Dairy'];
  }
}
