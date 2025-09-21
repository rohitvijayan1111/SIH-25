// Welcome Screen

import 'package:demo/screens/coop_dashboard.dart';
import 'package:demo/screens/coop_members.dart';
import 'package:demo/screens/earnings.dart';
import 'package:demo/screens/farmer_profile.dart';
import 'package:demo/screens/payment_details.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'CustomerScreens/customer_main_screen.dart';
import 'home_page.dart';
import 'voice_page.dart';
import 'view_cart_screen.dart';
import 'procurements_screen.dart';
import '../auth/signin.dart';
import 'CustomerScreens/signin_screen.dart';
<<<<<<< HEAD
import 'navigation_screen.dart';
=======
import 'coop_dashboard.dart';
import 'coop_members.dart';
import 'upload_produce.dart';
import 'earnings.dart';
>>>>>>> b739b9daf4fc4ca75e4856ec845971798b77c87e

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(), // smooth scroll
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              // Check if the screen is wide enough for a desktop layout
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

                      // Buttons
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

  // 🔑 Sign out function
  Future<void> _signOut(BuildContext context) async {
    try {
      await GoogleSignIn().signOut(); // Google sign out
    } catch (_) {}
    await FirebaseAuth.instance.signOut(); // Firebase sign out

    // Navigate back to SignIn page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  Widget _buildButtons(bool isWideScreen, BuildContext context) {
    // Buttons list
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
            // MaterialPageRoute(builder: (context) => const HomePage()),
            MaterialPageRoute(
              builder: (context) => const CustomerMainScreen(value: 1),
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
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignInScreen()),
        ),
        label: 'Customer App',
        color: Colors.blue,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ViewCartScreen()),
          );
        },
        label: "View My Cart",
        color: Colors.blue,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ProcurementsScreen()),
          );
        },
        label: "Procurements",
        color: Colors.indigo,
      ),

      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const DashboardScreen()),
          );
        },
        label: "Co-op MainScreen",
        color: Colors.red,
      ),

      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const EarningsScreen()),
          );
        },
        label: "Earnings Screen",
        color: Colors.red,
      ),

      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FarmerProfileScreen(),
            ),
          );
        },
        label: "Farmer's Profile",
        color: Colors.red,
      ),

      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const UploadProduceScreen(),
            ),
          );
        },
        label: "Upload Produce",
        color: Colors.red,
      ),
      _buildButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CooperativeMembersScreen(),
            ),
          );
        },
        label: "Co-op members",
        color: Colors.red,
      ),

      // 🔴 New Sign Out button
      _buildButton(
        onPressed: () async {
          await _signOut(context);
        },
        label: "Sign Out",
        color: Colors.red,
      ),

      // Inside _buildButtons in welcome_screen.dart
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
      // Wide screens: side by side
      return Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: buttonWidgets,
      );
    } else {
      // Mobile: stacked
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
