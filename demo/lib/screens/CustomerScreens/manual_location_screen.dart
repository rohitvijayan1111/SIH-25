import 'package:flutter/material.dart';

class ManualLocationScreen extends StatelessWidget {
  const ManualLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Choose Location'),
      ),
      body: const Center(
        child: Text('Map selection here'),
      ),
    );
  }
}
