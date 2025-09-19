import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/welcome_screen.dart';
import 'collect_details.dart';
// import 'form.dart';
import 'signup.dart';
import 'splashscreen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final String _selectedState = "Not Selected";
  final String _selectedDistrict = "Not Selected";
  Future<void> _signInWithGoogle() async {
    try {
      // Start Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // user cancelled

      // Get authentication details
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create Firebase credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = FirebaseFirestore.instance
            .collection('User')
            .doc(user.uid);
        final userSnapshot = await userDoc.get();

        if (userSnapshot.exists) {
          // ✅ User already exists → go to WelcomeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
          );
        } else {
          // ✅ New user → redirect to CollectDetails
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => CollectDetails(
                uid: user.uid,
                name: user.displayName ?? "Google User",
                email: user.email ?? "",
                authMethod: "Google Sign-In",
              ),
            ),
          );
        }
      }
    } catch (e) {
      _showErrorDialog("Error: ${e.toString()}");
    }
  }

  Future<void> _saveUserToFirestore(
    String uid,
    String name,
    String email,
    String authMethod,
  ) async {
    final userDoc = FirebaseFirestore.instance.collection('User').doc(uid);
    final userExists = await userDoc.get();
    if (!userExists.exists) {
      await userDoc.set({
        'name': name,
        'email': email,
        'authMethod': authMethod,
        'state': _selectedState,
        'district': _selectedDistrict,
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error", style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: [
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.1,
            vertical: height * 0.1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                'Hi! Welcome back, you have been missed.',
                style: TextStyle(fontSize: 18, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // Email field
              _buildInputField(
                controller: _emailController,
                label: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),

              // Password field
              _buildInputField(
                controller: _passwordController,
                label: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 10),

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email Sign In button
              _buildButton(
                label: "Sign in",
                color: Colors.deepPurple.shade300,
                textColor: Colors.white,
                onPressed: () async {
                  try {
                    UserCredential userCredential = await _auth
                        .signInWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                    print("Signed in as ${userCredential.user?.email}");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => SplashScreen()),
                    );
                  } catch (e) {
                    _showErrorDialog("Failed to sign in: $e");
                  }
                },
              ),
              const SizedBox(height: 20),

              Row(
                children: const [
                  Expanded(
                    child: Divider(color: Colors.white70, thickness: 1.2),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Or', style: TextStyle(color: Colors.white70)),
                  ),
                  Expanded(
                    child: Divider(color: Colors.white70, thickness: 1.2),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Google Sign In button
              _buildButton(
                label: "Continue with Google",
                color: Colors.white,
                textColor: Colors.black87,
                onPressed: () async => await _signInWithGoogle(),
              ),
              const SizedBox(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.white70),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: const Text(
                      'Sign up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mediaQuery.viewInsets.bottom),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Input field builder
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 14.0,
          ),
        ),
      ),
    );
  }

  // 🔹 Button builder
  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 3,
      ),
      child: Text(label, style: TextStyle(fontSize: 18, color: textColor)),
    );
  }
}
