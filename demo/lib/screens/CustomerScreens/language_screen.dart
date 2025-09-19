import 'package:flutter/material.dart';
import 'customer_main_screen.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String? _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hi, Rohit,', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Please select your preferred language'),
            const SizedBox(height: 24),
            RadioListTile<String>(
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (val) => setState(() => _selectedLanguage = val),
              title: const Text('English'),
            ),
            RadioListTile<String>(
              value: 'Hindi',
              groupValue: _selectedLanguage,
              onChanged: (val) => setState(() => _selectedLanguage = val),
              title: const Text('Hindi'),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CustomerMainScreen()));
                },
                child: const Text('Select'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
