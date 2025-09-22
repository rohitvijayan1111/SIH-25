// Welcome Screen
import 'package:demo/screens/CSC_interaction_screen.dart';
import 'package:demo/screens/CustomerScreens/agent.dart';
import 'package:demo/screens/CustomerScreens/customer_main_screen.dart';
import 'package:demo/screens/CustomerScreens/logistic.dart';
import 'package:demo/screens/CustomerScreens/product_history.dart'; // ✅ Import product history
import 'package:demo/screens/navigation_screen.dart';
import 'package:demo/screens/payment_details.dart';
import 'package:demo/screens/scanned_details.dart';
import 'package:demo/screens/voice_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:demo/screens/categories_screen.dart';

import '../auth/signin.dart';

import 'CustomerScreens/signin_screen.dart';
import 'navigation_screen.dart';
import 'coop_dashboard.dart';
import 'coop_members.dart';
import 'upload_produce.dart';
import 'earnings.dart';

import 'merge_products_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              bool isWideScreen = constraints.maxWidth > 600;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        "Welcome to the Shopping App",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      _buildButtons(isWideScreen, context),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await GoogleSignIn().signOut();
    } catch (_) {}
    await FirebaseAuth.instance.signOut();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  Widget _buildButtons(bool isWideScreen, BuildContext context) {
    final buttonWidgets = [
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const VoicePage()),
          );
        },
        label: "Add Product using Voice Feature",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CategoriesScreen()),
          );
        },
        label: "New Categories Screen",
        color: Colors.blue,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CustomerMainScreen(value: 1),
            ),
          );
        },
        label: "Go to Home Page",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NavigationScreen()),
          );
        },
        label: "Go to Navigation Page",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LogisticsDetailsPage(),
            ),
          );
        },
        label: "Logistics",
        color: Colors.teal,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BundleCreationScreen(),
            ),
          );
        },
        label: "Merge Products",
        color: Colors.teal,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AgentsPage()),
          );
        },
        label: "Agent",
        color: Colors.orange,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CSCSupportScreen()),
          );
        },
        label: "CSC Interaction Screen",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ScannedDetails()),
          );
        },
        label: "Scanned Product Details",
        color: Colors.green,
      ),

      // ✅ New Product History Button
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProductHistoryPage(),
            ),
          );
        },
        label: "Product History",
        color: Colors.blueGrey,
      ),

      _buildButton(
        onPressed: () async {
          await _signOut(context);
        },
        label: "Sign Out",
        color: Colors.red,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentDetailsScreen(
                paymentDetails: {
                  "totalAmount": 2000,
                  "paidAmount": 1679,
                  "dueAmount": 321,
                  "transactions": [
                    {
                      "method": "Cash",
                      "date": "2025-09-01T21:45:00",
                      "amount": 1679,
                    },
                  ],
                },
              ),
            ),
          );
        },
        label: "Payment Details",
        color: Colors.deepPurple,
      ),
    ];

    if (isWideScreen) {
      return Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: buttonWidgets,
      );
    } else {
      return Column(
        children: [
          ...buttonWidgets.map(
            (button) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: button,
            ),
          ),
        ],
      );
    }
  }

  Widget _buildButton({
    required VoidCallback onPressed,
    required String label,
    required Color color,
  }) {
    return SizedBox(
      width: 250,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
