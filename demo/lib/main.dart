import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Import screens
import 'screens/home_page.dart';
import 'screens/voice_page.dart';
import 'screens/view_cart_screen.dart';
import 'screens/procurements_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/product_details.dart';
import 'screens/payment_screen.dart';
import 'screens/payment_completion_screen.dart';
import 'screens/payment_details.dart';

import 'auth/signin.dart';
import 'auth/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentTheme = 1;

  void toggleTheme(int controll) {
    if (controll == 1) {
      setState(() {
        currentTheme = (currentTheme == 1) ? 0 : 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme == 1 ? ThemeData.light() : ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/signin': (context) => SignInPage(),
        '/home': (context) => const HomePage(),
        '/voice': (context) => const VoicePage(),
        '/cart': (context) => const ViewCartScreen(),
        '/procurements': (context) => const ProcurementsScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes with arguments
        switch (settings.name) {
          case '/productDetails':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => ProductDetailsScreen(product: args['product'], itemId: '',),
            );

          case '/paymentScreen':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PaymentScreen(order: args['order']),
            );

          case '/paymentCompletion':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PaymentCompletionScreen(
                amount: args['amount'],
                method: args['method'],
                dateTime: args['dateTime'],
              ),
            );

          case '/paymentDetails':
            final args = settings.arguments as Map<String, dynamic>;
            return MaterialPageRoute(
              builder: (_) => PaymentDetailsScreen(
                paymentDetails: args['paymentDetails'],
              ),
            );
        }
        return null; // if no route found
      },
    );
  }
}
