// TODO Implement this library.
import 'package:flutter/material.dart';

class VerifyProductsScreen extends StatefulWidget {
  const VerifyProductsScreen({super.key});

  @override
  State<VerifyProductsScreen> createState() => _VerifyProductsScreenState();
}

class _VerifyProductsScreenState extends State<VerifyProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Page')),
      body: const Center(
        child: Text('This is the Voice Page', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}
