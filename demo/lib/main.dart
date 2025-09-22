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

<<<<<<< HEAD
=======
// CURRENT
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'screens/home_page.dart';
// import 'screens/voice_page.dart';
// import 'screens/view_cart_screen.dart';
// import 'screens/procurements_screen.dart';

// import 'auth/signin.dart';
// import 'auth/splashscreen.dart';
// import 'global.dart';
// import 'screens/welcome_screen.dart';
// import 'controllers/app_controller.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // ✅ Initialize Firebase
//   // await Firebase.initializeApp(
//   //   // options: DefaultFirebaseOptions.currentPlatform, // if you used flutterfire configure
//   // );

//   // runApp(const MyApp());
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => AppController(),
//       child: const MyApp(),
//     ),
//   );
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
//       routes: {'/signin': (context) => SignInPage()},
//       home: WelcomeScreen(),
//       // home: StreamBuilder<User?>(
//       //   stream: FirebaseAuth.instance.authStateChanges(),
//       //   builder: (context, snapshot) {
//       //     if (snapshot.connectionState == ConnectionState.waiting) {
//       //       return SplashScreen();
//       //     }
//       //     if (snapshot.hasData) {
//       //       return WelcomeScreen();
//       //     } else {
//       //       return SignInPage();
//       //     }
//       //   },
//       // ),
//     );
//   }
// }


// NEW ONE WITH DYNAMIC TAB LAYOUT
>>>>>>> a5cd8fc71c4f24f3c31b6b4f89bd1a5ef69f210c
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/app_controller.dart';
import 'screens/categories_screen.dart';

<<<<<<< HEAD
import 'auth/signin.dart';
// ✅ Import your Product History page
import 'screens/CustomerScreens/product_history.dart';
import 'screens/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();

  runApp(const MyApp());
=======
void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppController(),
      child: const MyApp(),
    ),
  );
>>>>>>> a5cd8fc71c4f24f3c31b6b4f89bd1a5ef69f210c
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Tab App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF4285F4),
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const MainScreen(),
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      theme: currentTheme == 1 ? ThemeData.light() : ThemeData.dark(),
      routes: {
        '/signin': (context) => SignInPage(),
        '/productHistory': (context) => const ProductHistoryPage(), // ✅ Route still exists
      },
      // ✅ WelcomeScreen as home (button removed)
      home: Scaffold(
        appBar: AppBar(title: const Text("Main Page")),
        body: const WelcomeScreen(),
      ),

      // If you want auth flow back, uncomment this instead of home:
      /*
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen();
          }
          if (snapshot.hasData) {
            return const Scaffold(
              body: WelcomeScreen(),
            );
          } else {
            return SignInPage();
          }
        },
      ),
      */
=======
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: controller.getCurrentScreen(),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFF4285F4),
            unselectedItemColor: Colors.grey[600],
            currentIndex: controller.currentTabIndex,
            onTap: controller.changeTab,
            items: controller.currentTabs
                .map(
                  (tab) => BottomNavigationBarItem(
                    icon: Icon(tab.icon),
                    activeIcon: Icon(tab.activeIcon),
                    label: tab.label,
                  ),
                )
                .toList(),
          ),
        );
      },
>>>>>>> a5cd8fc71c4f24f3c31b6b4f89bd1a5ef69f210c
    );
  }
}
