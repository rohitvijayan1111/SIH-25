import 'package:flutter/material.dart';
import '../models/service_section.dart';
import '../screens/categories_screen.dart';
import '../screens/upload_produce_screen.dart';
import '../screens/coop_dashboard.dart';
import '../screens/CustomerScreens/home_screen.dart';
import '../screens/CustomerScreens/orders_screen.dart';
import '../screens/CustomerScreens/cart_screen.dart';
import '../screens/VendorScreens/procurement/procurement_screen.dart';
import '../screens/VendorScreens/dashboard/business_dashboard.dart';
import '../screens/VendorScreens/dashboard/inventory_screen.dart';
import '../screens/farmer_profile.dart';

class AppController extends ChangeNotifier {
  ServiceSection _currentSection = ServiceSection.categories;
  int _currentTabIndex = 0;

  ServiceSection get currentSection => _currentSection;
  int get currentTabIndex => _currentTabIndex;

  List<TabConfig> get currentTabs =>
      ServiceSections.configs[_currentSection]!.tabs;
  String get currentTitle => ServiceSections.configs[_currentSection]!.title;

  void navigateToSection(ServiceSection section, {int initialTab = 1}) {
    _currentSection = section;
    _currentTabIndex = initialTab;
    notifyListeners();
  }

  // void changeTab(int index) {
  //   _currentTabIndex = index;
  //   notifyListeners();
  // }

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

  // Widget getCurrentScreen() {
  //   switch (_currentSection) {
  //     case ServiceSection.categories:
  //       return _currentTabIndex == 0
  //           ? const CategoriesScreen()
  //           : const ProfilePlaceholderScreen();

  //     case ServiceSection.uploadProduce:
  //       return _currentTabIndex == 0
  //           ? const UploadProduceScreen()
  //           : const DashboardScreen();

  //     case ServiceSection.browseProducts:
  //       switch (_currentTabIndex) {
  //         case 0:
  //           return const HomeScreen(); // Browse tab
  //         case 1:
  //         case 2:
  //           return const OrdersScreen(); // Order tab
  //         case 3:
  //           return const CartScreen(); // Cart tab
  //         case 4:
  //           return const ProfilePlaceholderScreen();
  //         case 5:
  //           return const CategoriesScreen(); // Home tab
  //         default:
  //           return const CategoriesScreen();
  //       }

  //     case ServiceSection.farmerServices:
  //       return _currentTabIndex == 0
  //           ? const ProcurementScreen()
  //           : const BusinessDashboard();
  //   }
  // }

  Widget getCurrentScreen() {
    switch (_currentSection) {
      case ServiceSection.categories:
        return _currentTabIndex == 0
            ? const CategoriesScreen() // Home tab
            : const ProfilePlaceholderScreen(); // Profile tab

      case ServiceSection.uploadProduce:
        switch (_currentTabIndex) {
          case 0:
            return const CategoriesScreen(); // Home tab
          case 1:
            return const UploadProduceScreen(); // Upload Product tab
          case 2:
            return const DashboardScreen(); // Cooperative tab
          case 3:
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
            return const OrdersScreen(); // Order tab
          case 3:
            return const CartScreen(); // Cart tab
          case 4:
            return const ProfilePlaceholderScreen(); // Profile tab
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
            return const ProcurementScreen();
          case 3:
            return const InventoryScreen(); // Tool Renting tab
          case 4:
            return const ProfilePlaceholderScreen(); // Profile tab
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
            return const ProfilePlaceholderScreen(); // Profile tab
          default:
            return const CategoriesScreen();
        }
    }
  }
}

class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('Profile Screen', style: TextStyle(fontSize: 20)),
            Text('Coming Soon!'),
          ],
        ),
      ),
    );
  }
}
