import 'package:flutter/material.dart';

import 'auth/signin.dart';
import 'screens/home_page.dart';
import 'screens/procurements_screen.dart';
import 'screens/view_cart_screen.dart';
import 'screens/voice_page.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Initialize Firebase if required
  // await Firebase.initializeApp();

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

      // ✅ Register all the routes you want to use with pushNamed
      routes: {
        '/signin': (context) => SignInPage(),
        '/home': (context) => const HomePage(),        // ✅ added
        '/cart': (context) => const ViewCartScreen(),  // optional, for navigation back
        '/voice': (context) => const VoicePage(),      // optional
        '/procurements': (context) => const ProcurementsScreen(), // optional
      },

      // Your starting page
      home: WelcomeScreen(),
    );
  }
}
