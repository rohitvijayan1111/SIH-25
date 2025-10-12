import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/app_controller.dart';
import '../models/service_section.dart';
import '../widgets/service_card.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Column(
                children: [
                  // App logo/icon (you can add an icon here)
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:
                        // CircleAvatar(
                        // child:
                        Image.asset(
                          'assets/logoABC.jpg',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                    // ),
                  ),

                  SizedBox(height: 8),

                  // App Name with enhanced styling
                  Text(
                    'Agri Bharat Connect',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 2,
                    ),
                  ),

                  Text(
                    'ABC',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 4),

                  // Powered by section with enhanced design
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 16,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Powered by',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ONDC • Beckn Protocol',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.security,
                              size: 14,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Secured with Hyperledger Blockchain',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.8),
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ServiceCard(
                title: 'Upload Produce',
                subtitle: 'Everyday Essentials',
                icons: const [
                  Icons.upload,
                  Icons.local_shipping,
                  Icons.inventory_2,
                ],
                rightText: 'No min. order value',
                gradient: const LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  context.read<AppController>().navigateToSection(
                    ServiceSection.uploadProduce,
                  );
                },
              ),
              ServiceCard(
                title: 'Browse Products',
                subtitle: 'Fruits & Veggies',
                icons: const [Icons.shopping_basket, Icons.eco],
                rightText: 'Lowest prices',
                gradient: const LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF03DAC6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  context.read<AppController>().navigateToSection(
                    ServiceSection.browseProducts,
                  );
                },
              ),
              ServiceCard(
                title: 'Source and Sell',
                subtitle: 'Buy and Sell produce',

                icons: const [
                  Icons.handshake,
                  Icons.storefront,
                  Icons.inventory,
                ],
                rightText: 'Best quality guaranteed',
                gradient: const LinearGradient(
                  colors: [Color(0xFF09203f), Color(0xFF537895)],

                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  context.read<AppController>().navigateToSection(
                    ServiceSection.sourceAndSell,
                  );
                },
              ),
              ServiceCard(
                title: 'Farmer Services',
                subtitle: 'Tools & Fertilizers',
                icons: const [Icons.handyman, Icons.agriculture, Icons.store],
                rightText: 'Best quality guaranteed',
                gradient: const LinearGradient(
                  colors: [Color(0xFF006400), Color(0xFF228B22)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                onTap: () {
                  context.read<AppController>().navigateToSection(
                    ServiceSection.farmerEssentials,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
