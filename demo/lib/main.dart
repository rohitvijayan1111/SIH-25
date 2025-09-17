import 'package:flutter/material.dart';

// Import old screens
import 'screens/home_page.dart';
import 'screens/voice_page.dart';
import 'screens/view_cart_screen.dart';
import 'screens/procurements_screen.dart';

// Import new screens
import 'screens/payment_completion_screen.dart';
import 'screens/product_details.dart';
import 'screens/payment_screen.dart';
import 'screens/payment_details.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping App',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const WelcomeScreen(),

      // ✅ Dynamic routing for screens that need arguments
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());

          case '/voice':
            return MaterialPageRoute(builder: (_) => const VoicePage());

          case '/cart':
            return MaterialPageRoute(builder: (_) => const ViewCartScreen());

          case '/procurements':
            return MaterialPageRoute(builder: (_) => const ProcurementsScreen());

          case '/payment-completion':
            return MaterialPageRoute(builder: (_) => const PaymentCompletionScreen());

          case '/product-details':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(itemId: args['itemId']),
            );

          case '/payment-screen':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PaymentScreen(order: args['order']),
            );

          case '/payment-details':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PaymentDetailsScreen(paymentDetails: args['paymentDetails']),
            );

          default:
            return null;
        }
      },
    );
  }
}

/// Welcome Screen (unchanged, only old 4 buttons)
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

  Widget _buildButtons(bool isWideScreen, BuildContext context) {
    final buttonWidgets = [
      _buildButton(
        onPressed: () => Navigator.pushNamed(context, '/voice'),
        label: "Add Product using Voice Feature",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () => Navigator.pushNamed(context, '/home'),
        label: "Go to Home Page",
        color: Colors.green,
      ),
      _buildButton(
        onPressed: () => Navigator.pushNamed(context, '/cart'),
        label: "View My Cart",
        color: Colors.blue,
      ),
      _buildButton(
        onPressed: () => Navigator.pushNamed(context, '/procurements'),
        label: "Procurements",
        color: Colors.indigo,
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
