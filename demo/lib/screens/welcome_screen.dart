// Welcome Screen

import 'package:demo/screens/payment_details.dart';
import 'package:demo/screens/product_details.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'voice_page.dart';
import 'view_cart_screen.dart';
import 'procurements_screen.dart';
import '../auth/signin.dart';
import '../auth/splashscreen.dart';
import '../global.dart';

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

                      // We'll wrap the buttons in a new widget
                      // that changes based on screen size
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

  Widget _buildButtons(bool isWideScreen, BuildContext context) {
    // A list of the buttons you want to display
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
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        label: "Go to Home Page",
        color: Colors.green,
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
      // For wide screens, use a Row to put buttons side-by-side
      return Wrap(
        spacing: 16.0,
        runSpacing: 16.0,
        alignment: WrapAlignment.center,
        children: buttonWidgets,
      );
    } else {
      // For smaller screens, use a Column to stack the buttons
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
      width: 250, // Give the buttons a consistent width
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
