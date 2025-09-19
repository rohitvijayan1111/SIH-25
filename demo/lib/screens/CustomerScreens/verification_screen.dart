import 'package:flutter/material.dart';
import 'location_screen.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Number')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Verifying your number', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('We\'ve sent your verification code'),
            const TextField(decoration: InputDecoration(labelText: 'Enter OTP')),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LocationScreen()));
                },
                child: const Text('Verify'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
