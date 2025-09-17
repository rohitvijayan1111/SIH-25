import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/welcome_screen.dart';
import 'signin.dart';

import '../global.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    print("Initializing app...");

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        if (mounted) {
          _fetchUserData(user.uid);
          Future.delayed(Duration(seconds: 1), () {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            }
          });
        }
      } else {
        if (mounted) {
          Future.delayed(Duration(seconds: 1), () {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            }
          });
        }
      }
    });
  }

  Future<void> _fetchUserData(String userId) async {
    if (globalUserId == null || globalUsername == null) {
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        User? user = _auth.currentUser;
        if (user != null) {
          globalUserId = user.uid;
          globalUsername = user.displayName ?? 'User';
        } else {
          print("User details are not available.");
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/kyn.png', height: 100),
            SizedBox(height: 20),
            Text(
              "Loading...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
