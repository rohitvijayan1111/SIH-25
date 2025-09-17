// TODO Implement this library.
import 'package:flutter/material.dart';

class ProviderItemsScreen extends StatefulWidget {
  const ProviderItemsScreen({super.key});

  @override
  State<ProviderItemsScreen> createState() => _ProviderItemsScreenState();
}

class _ProviderItemsScreenState extends State<ProviderItemsScreen> {
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
