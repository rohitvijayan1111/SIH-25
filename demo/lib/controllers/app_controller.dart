import 'package:demo/screens/VendorScreens/vendor_profile.dart';
import 'package:demo/screens/my_coops_screen.dart';
import 'package:flutter/material.dart';

import '../models/service_section.dart';
// import '../screens/CustomerScreens/home_screen.dart';
import '../screens/CustomerScreens/orders_screen.dart';
import '../screens/VendorScreens/dashboard/business_dashboard.dart';
import '../screens/VendorScreens/dashboard/inventory_screen.dart';
import 'package:demo/screens/batch_history.dart';
import '../screens/VendorScreens/procurement/procurement_screen.dart';
import '../screens/categories_screen.dart';
import '../screens/farmer_profile.dart';
// import '../screens/new_upload_produce_screen.dart';
import '../screens/vcnew_upload_screen.dart';
import '../screens/scan_qr_screen.dart';
import '../screens/CustomerScreens/updated_home_screen.dart';
// import '../screens/VendorScreens/purchase_list_screen.dart';
import '../screens/VendorScreens/dynamic_purchase_list_screen.dart';

//profile screens
import 'package:demo/screens/main_profile_screen.dart';
import 'package:demo/screens/CustomerScreens/customer_profile.dart';
import 'package:demo/screens/VendorScreens/vendor_profile.dart';
import 'package:demo/screens/ConsumerPage/services_profile.dart';

class AppController extends ChangeNotifier {
  ServiceSection _currentSection = ServiceSection.categories;
  int _currentTabIndex = 0;

  ServiceSection get currentSection => _currentSection;
  int get currentTabIndex => _currentTabIndex;

  // Updated to require BuildContext
  List<TabConfig> currentTabs(BuildContext context) =>
      ServiceSections.configs(context)[_currentSection]!.tabs;

  String currentTitle(BuildContext context) =>
      ServiceSections.configs(context)[_currentSection]!.title;

  void navigateToSection(ServiceSection section, {int initialTab = 1}) {
    _currentSection = section;
    _currentTabIndex = initialTab;
    notifyListeners();
  }

  void changeTab(int index) {
    // If “Home” is tapped, always go back to Categories section
    if (index == 0) {
      _currentSection = ServiceSection.categories;
      _currentTabIndex = 0;
    } else {
      // Otherwise just switch within the current section
      _currentTabIndex = index;
    }
    notifyListeners();
  }

  void navigateHome() {
    navigateToSection(ServiceSection.categories);
  }

  Widget getCurrentScreen() {
    switch (_currentSection) {
      case ServiceSection.categories:
        return _currentTabIndex == 0
            ? const CategoriesScreen() // Home tab
            : ProfileScreen(); // Profile tab

      case ServiceSection.uploadProduce:
        switch (_currentTabIndex) {
          case 0:
            return const CategoriesScreen(); // Home tab
          case 1:
            return const UploadProduceScreen(); // Upload Product tab
          case 2:
            return BatchHistoryScreen();
          case 3:
            return MyCoopsScreen(); // Cooperative tab
          case 4:
            return const FarmerProfileScreen(); // Profile tab
          default:
            return const CategoriesScreen();
        }

      case ServiceSection.browseProducts:
        switch (_currentTabIndex) {
          case 0:
            return const CategoriesScreen(); // Home tab
          case 1:
            return const HomeScreen(); // Browse tab
          case 2:
            return const CameraQRScreen(); // Scan QR tab
          case 3:
            return const OrdersScreen(); // Orders tab
          case 4:
            return CustomerProfile(); // Profile tab
          default:
            return const CategoriesScreen();
        }

      case ServiceSection.sourceAndSell:
        switch (_currentTabIndex) {
          case 0:
            return const CategoriesScreen(); // Home tab
          case 1:
            return const BusinessDashboard(); // Farmer Shop tab
          case 2:
            return const ProcurementScreen(); // Procurement tab
          case 3:
            return PurchaseListScreen(); // Inventory tab
          case 4:
            return MiddlemanProfile(); // Profile tab
          default:
            return const CategoriesScreen();
        }

      case ServiceSection.farmerEssentials:
        switch (_currentTabIndex) {
          case 0:
            return const CategoriesScreen(); // Home tab
          case 1:
            return const HomeScreen(value: 1); // Tool Renting tab
          case 2:
            return const BusinessDashboard(); // Farmer Shop tab
          case 3:
            return FarmerProfile(); // Profile tab
          default:
            return const CategoriesScreen();
        }
    }
  }
}

// class ProfilePlaceholderScreen extends StatelessWidget {
//   const ProfilePlaceholderScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: Colors.white,
//         foregroundColor: Colors.black87,
//       ),
//       body: const Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.person, size: 80, color: Colors.grey),
//             SizedBox(height: 16),
//             Text('Profile Screen', style: TextStyle(fontSize: 20)),
//             Text('Coming Soon!'),
//           ],
//         ),
//       ),
//     );
//   }
// }
