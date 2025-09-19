import 'package:flutter/material.dart';
import 'language_screen.dart';
import 'manual_location_screen.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location')),
      body: Column(
        children: [
          const Expanded(child: Center(child: Text('Map/Location Widget Here'))),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LanguageScreen()));
                },
                child: const Text('Use Current Location'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const ManualLocationScreen()));
                },
                child: const Text('Manual Location'),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
