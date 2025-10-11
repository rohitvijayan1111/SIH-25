// import 'package:flutter/material.dart';

// import 'auth/signin.dart';
// import 'screens/home_page.dart';
// import 'screens/procurements_screen.dart';
// import 'screens/view_cart_screen.dart';
// import 'screens/voice_page.dart';
// import 'screens/welcome_screen.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // ✅ Initialize Firebase if required
//   // await Firebase.initializeApp();

//   runApp(const MyApp());
// }

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int currentTheme = 1;

//   void toggleTheme(int controll) {
//     if (controll == 1) {
//       setState(() {
//         currentTheme = (currentTheme == 1) ? 0 : 1;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: currentTheme == 1 ? ThemeData.light() : ThemeData.dark(),

//       // ✅ Register all the routes you want to use with pushNamed
//       routes: {
//         '/signin': (context) => SignInPage(),
//         '/home': (context) => const HomePage(),        // ✅ added
//         '/cart': (context) => const ViewCartScreen(),  // optional, for navigation back
//         '/voice': (context) => const VoicePage(),      // optional
//         '/procurements': (context) => const ProcurementsScreen(), // optional
//       },

//       // Your starting page
//       home: WelcomeScreen(),
//     );
//   }
// }
import 'package:demo/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'controllers/app_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  print('BASE_URL: ${dotenv.env['BASE_URL']}');

  // await dotenv.load();

  // Initialize Firebase
  // await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Agri Bharat Connect',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4285F4),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        // '/signin': (context) => const SignInPage(),
        // '/productHistory': (context) => const ProductHistoryPage(),
      },
      // home: const SignInPage(),
      home: MainScreen(),
      // home: ProductHistoryPage(),
      // home: BuyerRequestsScreen(),
      // home: RequestDetailsScreen(),
    );
  }
}
