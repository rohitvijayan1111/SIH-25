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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Categories',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
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
