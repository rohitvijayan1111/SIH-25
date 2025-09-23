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
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: const Text(
      //     'Categories',
      //     style: TextStyle(
      //       color: Colors.black87,
      //       fontSize: 20,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // const SizedBox(height: 8),

            // // App Name
            // const Text(
            //   'ABC (Agri Bharat Connect)',
            //   style: TextStyle(
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold,
            //     color: Color(0xFF2e384d),
            //   ),
            //   textAlign: TextAlign.center,
            // ),

            // const SizedBox(height: 6),

            // // Powered by description
            // const Text(
            //   'Powered by ONDC and Beckn protocol, secured with Hyperledger blockchain',
            //   style: TextStyle(
            //     fontSize: 14,
            //     color: Color(0xFF586690),
            //     height: 1.3,
            //   ),
            //   textAlign: TextAlign.center,
            // ),

            // const SizedBox(height: 20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4CAF50), // Fresh green
                    Color(0xFF2196F3), // Sky blue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.only(bottom: 14),
              child: Column(
                children: [
                  // App logo/icon (you can add an icon here)
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Icon(
                      Icons.agriculture,
                      size: 32,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 16),

                  // App Name with enhanced styling
                  Text(
                    'Agri Bharat Connect',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 2,
                    ),
                  ),

                  Text(
                    'ABC',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(height: 12),

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
                              color: Colors.white.withOpacity(0.9),
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Powered by',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.8),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'ONDC • Beckn Protocol',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
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
                              color: Colors.white.withOpacity(0.9),
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Secured with Hyperledger Blockchain',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white.withOpacity(0.8),
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
            ),
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

              icons: const [Icons.handshake, Icons.storefront, Icons.inventory],
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
    );
  }
}
