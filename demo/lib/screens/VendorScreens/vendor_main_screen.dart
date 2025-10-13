import 'package:flutter/material.dart';
// Import your existing screens
import 'home_screen.dart'; // This is your main dashboard
import 'procurement/procurement_screen.dart';
import 'dashboard/inventory_screen.dart';
import '../navigation_screen.dart';
import 'dashboard/business_dashboard.dart';
import 'utils/constantdata.dart';

void main() {
  runApp(const VendorApp());
}

class VendorApp extends StatelessWidget {
  const VendorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vendor Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4285F4),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      home: const MainNavigationScreen(), // START WITH DASHBOARD SCREEN
      debugShowCheckedModeBanner: false,
    );
  }
}

// MAIN NAVIGATION SCREEN - Starts with your home_screen.dart as Dashboard
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0; // START WITH DASHBOARD TAB (your home_screen.dart)

  final List<Widget> _screens = [
    const MiddlemanHomeScreen(), // Dashboard tab - YOUR EXISTING home_screen.dart
    ProcurementScreen(), // Procurement tab - YOUR EXISTING SCREEN
    const InventoryScreen(), // Inventory tab - YOUR EXISTING SCREEN
    const BusinessDashboard(), // Market tab - YOUR EXISTING business_dashboard.dart
    const ProfileScreen(), // Profile tab - Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF4285F4),
        unselectedItemColor: const Color(0xFF616161),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Procurement',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2),
            label: 'Inventory',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.trending_up),
            label: 'Market',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

// Profile placeholder screen
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Profile', style: TextStyle(color: Colors.black87)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            // Navigate to categories screen
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NavigationScreen()),
            );
          },
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 80, color: Color(0xFF4285F4)),
            SizedBox(height: 16),
            Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

// CATEGORIES SCREEN - Accessible via back button
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
            // Upload Produce Card
            _buildServiceCard(
              title: 'Upload Produce',
              subtitle: 'Everyday Essentials',
              gradient: const LinearGradient(
                colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              rightText: 'No min. order value',
              icons: const [
                Icons.upload,
                Icons.local_shipping,
                Icons.inventory_2,
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Upload Produce coming soon!')),
                );
              },
            ),

            // Browse Products Card
            _buildServiceCard(
              title: 'Browse Products',
              subtitle: 'Fruits & Veggies',
              gradient: const LinearGradient(
                colors: [Color(0xFF2196F3), Color(0xFF03DAC6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              rightText: 'Lowest prices',
              icons: const [Icons.circle, Icons.circle, Icons.circle],
              iconColors: const [Colors.red, Colors.yellow, Colors.green],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Browse Products coming soon!')),
                );
              },
            ),

            // Procure Supplies Card
            _buildServiceCard(
              title: 'Procure Supplies',
              subtitle: 'Seeds & Fertilizers',
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              rightText: 'Lowest prices',
              icons: const [Icons.circle, Icons.circle, Icons.circle],
              iconColors: const [Colors.red, Colors.yellow, Colors.green],
              onTap: () {
                // Navigate back to Dashboard
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MainNavigationScreen(),
                  ),
                );
              },
            ),

            // Farmer Services Card
            _buildServiceCard(
              title: 'Farmer Services',
              subtitle: 'Lowest Prices Ever',
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF8BC34A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              rightText: 'Minimum order value ₹599',
              icons: const [
                Icons.local_shipping,
                Icons.shopping_cart,
                Icons.diamond,
              ],
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Farmer Services coming soon!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required String title,
    required String subtitle,
    required LinearGradient gradient,
    required String rightText,
    required List<IconData> icons,
    List<Color>? iconColors,
    required VoidCallback onTap,
  }) {
    return Container(
      height: 120,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: icons.asMap().entries.map((entry) {
                        int index = entry.key;
                        IconData icon = entry.value;
                        Color iconColor =
                            iconColors != null && index < iconColors.length
                            ? iconColors[index]
                            : Colors.white;

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Icon(icon, color: iconColor, size: 16),
                        );
                      }).toList(),
                    ),
                    Text(
                      rightText,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
