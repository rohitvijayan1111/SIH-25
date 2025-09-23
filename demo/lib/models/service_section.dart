import 'package:flutter/material.dart';

enum ServiceSection {
  categories,
  uploadProduce,
  browseProducts,
  sourceAndSell,
  farmerEssentials,
}

class ServiceSectionConfig {
  final String title;
  final List<TabConfig> tabs;

  ServiceSectionConfig({required this.title, required this.tabs});
}

class TabConfig {
  final String label;
  final IconData icon;
  final IconData activeIcon;

  TabConfig({
    required this.label,
    required this.icon,
    required this.activeIcon,
  });
}

class ServiceSections {
  static Map<ServiceSection, ServiceSectionConfig> configs = {
    ServiceSection.categories: ServiceSectionConfig(
      title: 'Categories',
      tabs: [
        TabConfig(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        TabConfig(
          label: 'Profile',
          icon: Icons.person_outline,
          activeIcon: Icons.person,
        ),
      ],
    ),
    ServiceSection.uploadProduce: ServiceSectionConfig(
      title: 'Upload Produce',
      tabs: [
        TabConfig(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        TabConfig(
          label: 'Upload Product',
          icon: Icons.upload_outlined,
          activeIcon: Icons.upload,
        ),
        TabConfig(
          label: 'Seller Requests',
          icon: Icons.list_alt_outlined,
          activeIcon: Icons.list_alt,
        ),
        TabConfig(
          label: 'Cooperative',
          icon: Icons.group_outlined,
          activeIcon: Icons.group,
        ),
        TabConfig(
          label: 'Profile',
          icon: Icons.person_outline,
          activeIcon: Icons.person,
        ),
      ],
    ),
    ServiceSection.browseProducts: ServiceSectionConfig(
      title: 'Browse Products',
      tabs: [
        TabConfig(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        TabConfig(
          label: 'Browse',
          icon: Icons.search_outlined,
          activeIcon: Icons.search,
        ),
        TabConfig(
          label: 'Scan QR',
          icon: Icons.qr_code_scanner_outlined,
          activeIcon: Icons.qr_code_scanner,
        ),

        TabConfig(
          label: 'Orders',
          icon: Icons.shopping_bag_outlined,
          activeIcon: Icons.shopping_bag,
        ),
        // TabConfig(
        //   label: 'Cart',
        //   icon: Icons.shopping_cart_outlined,
        //   activeIcon: Icons.shopping_cart,
        // ),
        TabConfig(
          label: 'Profile',
          icon: Icons.person_outline,
          activeIcon: Icons.person,
        ),
      ],
    ),
    ServiceSection.sourceAndSell: ServiceSectionConfig(
      title: 'Source and Sell',
      tabs: [
        TabConfig(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        TabConfig(
          label: 'Dashboard',
          icon: Icons.dashboard_outlined,
          activeIcon: Icons.dashboard,
        ),
        TabConfig(
          label: 'Procurement',
          icon: Icons.receipt_long_outlined,
          activeIcon: Icons.receipt_long,
        ),
        TabConfig(
          label: 'Inventory',
          icon: Icons.inventory_2_outlined,
          activeIcon: Icons.inventory,
        ),
        TabConfig(
          label: 'Profile',
          icon: Icons.person_outline,
          activeIcon: Icons.person,
        ),
      ],
    ),
    ServiceSection.farmerEssentials: ServiceSectionConfig(
      title: 'Farmer Essentials',
      tabs: [
        TabConfig(
          label: 'Home',
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
        ),
        TabConfig(
          label: 'Farmer Shop',
          icon: Icons.store_outlined,
          activeIcon: Icons.store,
        ),
        TabConfig(
          label: 'Other Services',
          icon: Icons.store_outlined,
          activeIcon: Icons.store,
        ),
        TabConfig(
          label: 'Profile',
          icon: Icons.person_outline,
          activeIcon: Icons.person,
        ),
      ],
    ),
  };
}
