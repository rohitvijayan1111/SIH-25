import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import 'orders_screen.dart';
import 'profile_screen.dart';

class CustomerMainScreen extends StatefulWidget {
  const CustomerMainScreen({super.key});

  @override
  State<CustomerMainScreen> createState() => _CustomerMainScreenState();
}

class _CustomerMainScreenState extends State<CustomerMainScreen> {
  // Current tab index (0 = Home, 1 = Favorites, 2 = Orders, 3 = Profile)
  int currentIndex = 0;

  // List of screens to show for each tab
  final List<Widget> screens = [
    const HomeScreen(), // Tab 0: Home/Browse
    const FavoritesScreen(), // Tab 1: Favorites
    const OrdersScreen(), // Tab 2: Orders
    const ProfileScreen(), // Tab 3: Profile
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // Show the current screen based on selected tab
      body: screens[currentIndex],

      // Bottom navigation bar with 4 tabs
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index; // Switch to selected tab
          });
        },
        type: BottomNavigationBarType.fixed, // Show all tabs
        selectedItemColor: const Color(0xFF4CAF50), // Green for selected
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            activeIcon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
