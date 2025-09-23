class Product {
  final String id;
  final String name;
  final String price;
  final String imageUrl;
  final String category;
  final String description;
  final String farmerName;
  bool isFavorite;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.description = '',
    this.farmerName = '',
    this.isFavorite = false,
  });
   String get displayPrice => 'Average price: \$${double.tryParse(price)?.toStringAsFixed(0) ?? price}';


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

  factory Product.empty() {
    return Product(
      id: '',
      name: 'Unknown Product',
      price: '0',
      imageUrl: '',
      category: 'Unknown',
      description: '',
      farmerName: '',
      isFavorite: false,
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
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQX_h4_fnBVxubY3QkeC1fTDUZQM1YQj-WaXg&s',
        category: 'Herbicide',
        description: 'Broad-spectrum systemic herbicide for weed control',
        farmerName: 'AgroChem Pvt Ltd',
        isFavorite: true,
      ),
      Product(
        id: 'H2',
        name: 'Paraquat',
        price: '280',
        imageUrl:
            'https://image.made-in-china.com/2f0j00ilzktfLqRQou/Chinese-Factory-Herbicides-Paraquat-20-SL-276g-L-SL.jpg',
        category: 'Herbicide',
        description: 'Fast-acting herbicide for non-selective weed removal',
        farmerName: 'GreenGrow Solutions',
        isFavorite: false,
      ),
      Product(
        id: 'H3',
        name: '2,4-D Amine Salt',
        price: '300',
        imageUrl:
            'https://tse1.mm.bing.net/th/id/OIP.fJL4INSjcI66D-EH5_K9oAHaHa?pid=Api&P=0&h=180',
        category: 'Herbicide',
        description: 'Selective weed killer for cereal crops',
        farmerName: 'FarmWell',
        isFavorite: true,
      ),
      Product(
        id: 'H4',
        name: 'Atrazine',
        price: '270',
        imageUrl:
            'https://5.imimg.com/data5/SELLER/Default/2021/9/XY/MW/TG/78974752/atrazine-50-wp-selective-herbicide-1000x1000.jpg',
        category: 'Herbicide',
        description: 'Pre- and post-emergence herbicide for maize & sugarcane',
        farmerName: 'CropCare Agro',
        isFavorite: false,
      ),
      Product(
        id: 'H5',
        name: 'Pendimethalin',
        price: '320',
        imageUrl:
            'https://image.made-in-china.com/2f0j00jJpiablIAUkw/Agrochemical-Herbicide-Pendimethalin-95-Tc-330-G-L-Ec-33-Ec.jpg',
        category: 'Herbicide',
        description: 'Pre-emergent herbicide effective for grasses and weeds',
        farmerName: 'Farmer Supply Co',
        isFavorite: false,
      ),

      // 🌿 Growth Regulators
      Product(
        id: 'GR1',
        name: 'Gibberellic Acid',
        price: '150',
        imageUrl:
            'https://5.imimg.com/data5/SELLER/Default/2024/2/385609168/ZO/YL/VH/28119585/img-20240209-wa0169-1000x1000.jpg',
        category: 'Growth Regulators',
        description: 'Stimulates stem elongation and seed germination',
        farmerName: 'BioAgro Labs',
        isFavorite: true,
      ),
      Product(
        id: 'GR2',
        name: 'Cytokinin Spray',
        price: '180',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQA8BjHvhJaofV5DngwKdAMfrwKvddIVW5uYA&s',
        category: 'Growth Regulators',
        description: 'Promotes cell division and leaf expansion',
        farmerName: 'AgriBioTech',
        isFavorite: false,
      ),
      Product(
        id: 'GR3',
        name: 'Ethrel',
        price: '200',
        imageUrl:
            'https://5.imimg.com/data5/ECOM/Default/2023/11/361147881/XM/DA/JH/59373149/ethrel-4-500x500.png',
        category: 'Growth Regulators',
        description: 'Regulates fruit ripening and flower induction',
        farmerName: 'FarmChem India',
        isFavorite: true,
      ),
      Product(
        id: 'GR4',
        name: 'Naphthalene Acetic Acid (NAA)',
        price: '170',
        imageUrl:
            'https://image.made-in-china.com/2f0j00ZJqaLMNPfkrH/Naphthalene-Acetic-Acid-Naa-Plant-Growth-Regulator.jpg',
        category: 'Growth Regulators',
        description: 'Helps in root initiation and fruit thinning',
        farmerName: 'AgroLife Sciences',
        isFavorite: false,
      ),
      Product(
        id: 'GR5',
        name: 'Paclobutrazol',
        price: '220',
        imageUrl:
            'https://image.made-in-china.com/2f0j00VjalAcTZhWur/Agriculture-Paclobutrazol-Powder-15-Wp-Paclobutrazol-for-Mango.jpg',
        category: 'Growth Regulators',
        description: 'Plant growth retardant for uniform flowering',
        farmerName: 'GrowTech Agro',
        isFavorite: false,
      ),

      // 🍄 Fungicide
      Product(
        id: 'F1',
        name: 'Mancozeb',
        price: '250',
        imageUrl:
            'https://5.imimg.com/data5/SELLER/Default/2022/1/HY/IX/IN/4089734/carbendazim-12-mancozeb-63-wp-500x500.jpg',
        category: 'Fungicide',
        description: 'Broad-spectrum fungicide for fruits and vegetables',
        farmerName: 'SafeCrop Ltd',
        isFavorite: true,
      ),
      Product(
        id: 'F2',
        name: 'Carbendazim',
        price: '200',
        imageUrl:
            'https://5.imimg.com/data5/SELLER/Default/2023/5/310342696/YQ/WZ/GO/148816997/carbendazim-systemic-fungicide-500x500.jpg',
        category: 'Fungicide',
        description: 'Systemic fungicide effective against seed-borne diseases',
        farmerName: 'BioCrop Care',
        isFavorite: false,
      ),
      Product(
        id: 'F3',
        name: 'Copper Oxychloride',
        price: '220',
        imageUrl:
            'https://media.prod.bunnings.com.au/api/public/content/969c55089f4e480ba87035443aba8f92?v=f0d4a702&t=w500dpr1',
        category: 'Fungicide',
        description: 'Contact fungicide for vegetables and fruits',
        farmerName: 'AgriGuard',
        isFavorite: false,
      ),
      Product(
        id: 'F4',
        name: 'Sulphur Dust',
        price: '180',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYcYseOqOiWGW1tHCwSIaWbb7vHXhQOVJZxw&s',
        category: 'Fungicide',
        description: 'Effective for powdery mildew control',
        farmerName: 'AgroSafe',
        isFavorite: true,
      ),
      Product(
        id: 'F5',
        name: 'Hexaconazole',
        price: '300',
        imageUrl:
            'https://5.imimg.com/data5/SELLER/Default/2022/2/NQ/RN/AF/21021813/image-29-1000x1000.jpg',
        category: 'Fungicide',
        description: 'Systemic fungicide for rice and groundnut crops',
        farmerName: 'GreenCrop Agro',
        isFavorite: false,
      ),

      // 🌱 Growth Promoter
      Product(
        id: 'GP1',
        name: 'Seaweed Extract',
        price: '280',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiTI1zAvog3LjqRxic4YVOvH6waK4aT5u8bQ&s',
        category: 'Growth Promoter',
        description: 'Natural plant growth promoter',
        farmerName: 'BioGrow Organics',
        isFavorite: false,
      ),
      Product(
        id: 'GP2',
        name: 'Humic Acid',
        price: '240',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjLgpKPjSKFIZwLkmZRbtxtwopefLf0uijUQ&s',
        category: 'Growth Promoter',
        description: 'Improves soil fertility and root growth',
        farmerName: 'EcoFarm Solutions',
        isFavorite: true,
      ),
      Product(
        id: 'GP3',
        name: 'Amino Acid Spray',
        price: '300',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSoLii5ff8BQ1Eb9e95vpfHc_kOcgYz4dUzwg&s',
        category: 'Growth Promoter',
        description: 'Enhances nutrient uptake and stress tolerance',
        farmerName: 'AgroBoost',
        isFavorite: true,
      ),
      Product(
        id: 'GP4',
        name: 'Organic Compost Tea',
        price: '200',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLyb2yG5XgWQsfoPEftiQ9W-hNjLMQ1q2WiQ&s',
        category: 'Growth Promoter',
        description: 'Boosts microbial activity in soil',
        farmerName: 'FarmPure',
        isFavorite: false,
      ),
      Product(
        id: 'GP5',
        name: 'Silicon Spray',
        price: '260',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRpl3b7SWNZrEs8QMippty5fg8OSPv6dAl0A&s',
        category: 'Growth Promoter',
        description: 'Improves plant resistance against stress',
        farmerName: 'CropShield',
        isFavorite: false,
      ),

      // 🌾 Fertilizer
      Product(
        id: 'FT1',
        name: 'Urea',
        price: '550',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQR3ss0Wd5DdrPR9R1UF8Xb1p4Tm8i6jrkm9w&s',
        category: 'Fertilizer',
        description: 'Nitrogen-based fertilizer for all crops',
        farmerName: 'AgriInput Suppliers',
        isFavorite: true,
      ),
      Product(
        id: 'FT2',
        name: 'DAP (Diammonium Phosphate)',
        price: '1200',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRFCQyLYHmQAqIL6mt9QXSOhaSbk3xKsZlGwQ&s',
        category: 'Fertilizer',
        description: 'Source of phosphorus and nitrogen',
        farmerName: 'CropCare Inputs',
        isFavorite: false,
      ),
      Product(
        id: 'FT3',
        name: 'MOP (Muriate of Potash)',
        price: '1000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1NFhcI1SRSDS1135ZINOLvPxPn0OEDCF60Q&s',
        category: 'Fertilizer',
        description: 'Potassium-rich fertilizer for crop growth',
        farmerName: 'Kisan Agro',
        isFavorite: false,
      ),
      Product(
        id: 'FT4',
        name: 'Ammonium Sulphate',
        price: '900',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3qmqXtwgQPYwn-JCtJi9H18BnGX4_fKj8xg&s',
        category: 'Fertilizer',
        description: 'Nitrogen and sulphur source',
        farmerName: 'FarmChem Industries',
        isFavorite: false,
      ),
      Product(
        id: 'FT5',
        name: 'Organic Manure',
        price: '400',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSInBaCESWDsyNQFK1rjhX40_lhSDwQBnpD4g&s',
        category: 'Fertilizer',
        description: 'Eco-friendly soil enhancer',
        farmerName: 'EcoGrow Farms',
        isFavorite: true,
      ),

      // ⚡ Micro Nutrient
      Product(
        id: 'MN1',
        name: 'Zinc Sulphate',
        price: '350',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSjY36-GOK0vfea5BX8MRiDCCnJ1pH1ixf9eQ&s',

        category: 'Micro Nutrient',
        description: 'Corrects zinc deficiency in crops',
        farmerName: 'MicroGrow',
        isFavorite: false,
      ),
      Product(
        id: 'MN2',
        name: 'Boron Spray',
        price: '280',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTs43P1xyBxi-n_lcPQmnBtfZeeDDlbDk_alA&s',
        category: 'Micro Nutrient',
        description: 'Enhances fruit and seed development',
        farmerName: 'NutriCrop',
        isFavorite: true,
      ),
      Product(
        id: 'MN3',
        name: 'Ferrous Sulphate',
        price: '260',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSxySoYNu8IxqG7OTv1M9vU6uLooObsLmJkQg&s',
        category: 'Micro Nutrient',
        description: 'Treats iron deficiency chlorosis',
        farmerName: 'AgriNutra',
        isFavorite: false,
      ),
      Product(
        id: 'MN4',
        name: 'Manganese Sulphate',
        price: '270',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8bp_aH4H8Bj02Z_B793kYYEDof25syyQdgg&s',
        category: 'Micro Nutrient',
        description: 'Essential for enzyme activity in plants',
        farmerName: 'CropBalance',
        isFavorite: false,
      ),
      Product(
        id: 'MN5',
        name: 'Copper Sulphate',
        price: '290',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKkMDHflQX7svMC5_PRYsFl3fSS_g4R42Clw&s',
        category: 'Micro Nutrient',
        description: 'Improves plant metabolism',
        farmerName: 'AgriMicro',
        isFavorite: false,
      ),

      // 🌱 Seeds
      Product(
        id: 'S1',
        name: 'Hybrid Maize Seeds',
        price: '800',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQ51WvjCfayDfPQRc6fPPeIG8Q2_YcaKjbug&s',
        category: 'Seeds',
        description: 'High-yielding hybrid maize variety',
        farmerName: 'SeedWorld',
        isFavorite: false,
      ),
      Product(
        id: 'S2',
        name: 'Paddy Seeds',
        price: '900',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLNG78T-gdLJX_4kMhBz9kRYPISJYb8rjDfA&s',
        category: 'Seeds',
        description: 'Quality rice seeds for better yield',
        farmerName: 'Kisan Seeds',
        isFavorite: true,
      ),
      Product(
        id: 'S3',
        name: 'Vegetable Seeds Pack',
        price: '600',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUJTQxvpplloCrqWovEK9rMcyt8E0P2uxmEQ&s',
        category: 'Seeds',
        description: 'Mix of tomato, chili, and okra seeds',
        farmerName: 'AgriSeed Co',
        isFavorite: false,
      ),
      Product(
        id: 'S4',
        name: 'Wheat Seeds',
        price: '750',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSBvdiGFmQ6Ml9wtCa3KbNLetvtlSF7zU7UHg&s',
        category: 'Seeds',
        description: 'Improved wheat seed variety',
        farmerName: 'GrainSeed Corp',
        isFavorite: false,
      ),
      Product(
        id: 'S5',
        name: 'Cotton Seeds',
        price: '950',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ91NVXE_j7V0t7fmKRHrbANp-_Qq-0RukUJA&s',
        category: 'Seeds',
        description: 'BT cotton seeds for high yield',
        farmerName: 'AgroSeed India',
        isFavorite: true,
      ),

      // 🏞️ Land Lease & Sale
      Product(
        id: 'LL1',
        name: '2 Acre Fertile Land - Lease',
        price: '50000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTCGoH2EK9STd6ZYv2Tu1buE6r9obtq6eCVdQ&s',
        category: 'Land Lease & Sale',
        description: 'Well-irrigated land suitable for vegetables',
        farmerName: 'Farmer Prakash',
        isFavorite: true,
      ),
      Product(
        id: 'LL2',
        name: '5 Acre Paddy Land - Sale',
        price: '1200000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfeF5FpqNuWe33M6-AJyklgtl9LhptYbu3dQ&s',
        category: 'Land Lease & Sale',
        description: 'Prime land with water source',
        farmerName: 'Farmer Suresh',
        isFavorite: false,
      ),
      Product(
        id: 'LL3',
        name: '3 Acre Orchard Land - Lease',
        price: '70000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiBc204NyE1I_hz2YCeVTNodNPMpyabLU9jg&s',
        category: 'Land Lease & Sale',
        description: 'Land suited for mango & guava orchards',
        farmerName: 'Farmer Radha',
        isFavorite: false,
      ),
      Product(
        id: 'LL4',
        name: '10 Acre Farmland - Sale',
        price: '2500000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRwZ3U3t4sk83eSoASofTMFWGz4Qrvi6j3igA&s',
        category: 'Land Lease & Sale',
        description: 'Irrigated fertile soil, ideal for cash crops',
        farmerName: 'Farmer Nanda',
        isFavorite: true,
      ),
      Product(
        id: 'LL5',
        name: '1 Acre Vegetable Plot - Lease',
        price: '30000',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAYrdCKppYfBCsJgMgtZiXnMjqlCJTuT392A&s',
        category: 'Land Lease & Sale',
        description: 'Small plot for seasonal vegetables',
        farmerName: 'Farmer Rekha',
        isFavorite: false,
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
      Product(
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
      Product(
        id: '2',
        name: 'Papaya',
        price: '80',
        imageUrl: 'assets/CustomerUIAssets/images/papaya.jpg',
        category: 'Fruits',
        description: 'Sweet and juicy papaya',
        farmerName: 'Farmer Mary',
        isFavorite: false,
      ),
      Product(
        id: '3',
        name: 'Tomatoes',
        price: '60',
        imageUrl: 'assets/CustomerUIAssets/images/tomato.jpg',
        category: 'Vegetables',
        description: 'Red ripe tomatoes',
        farmerName: 'Farmer Bob',
        isFavorite: false,
      ),
      Product(
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
      Product(
        id: '6',
        name: 'Banana',
        price: '30',
        imageUrl: 'assets/CustomerUIAssets/images/banana.jpg',
        category: 'Fruits',
        description: 'Fresh bananas, source of potassium',
        farmerName: 'Farmer Kumar',
        isFavorite: false,
      ),

      Product(
        id: '8',
        name: 'Wheat',
        price: '25',
        imageUrl: 'assets/CustomerUIAssets/images/wheat.jpg',
        category: 'Grains',
        description: 'High-quality wheat grains',
        farmerName: 'Farmer Ramesh',
        isFavorite: false,
      ),
      Product(
        id: '9',
        name: 'Rice',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/rice.jpg',
        category: 'Grains',
        description: 'Premium basmati rice',
        farmerName: 'Farmer Devi',
        isFavorite: true,
      ),
      Product(
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
      Product(
        id: '11',
        name: 'Milk',
        price: '52',
        imageUrl: 'assets/CustomerUIAssets/images/milk.jpg',
        category: 'Dairy',
        description: 'Fresh cow milk delivered daily',
        farmerName: 'Dairy Farmhouse',
        isFavorite: true,
      ),
      Product(
        id: '12',
        name: 'Paneer',
        price: '210',
        imageUrl: 'assets/CustomerUIAssets/images/paneer.jpg',
        category: 'Dairy',
        description: 'Soft cottage cheese, homemade',
        farmerName: 'Farmer Shanti',
      ),
      Product(
        id: '13',
        name: 'Curd',
        price: '50',
        imageUrl: 'assets/CustomerUIAssets/images/curd.jpg',
        category: 'Dairy',
        description: 'Thick curd from desi cows',
        farmerName: 'Farmer Anil',
        isFavorite: true,
      ),
      Product(
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
