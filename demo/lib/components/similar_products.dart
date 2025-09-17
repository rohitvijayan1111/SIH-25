// TODO Implement this library.
import 'package:flutter/material.dart';

class SimilarProducts extends StatefulWidget {
  const SimilarProducts({super.key});

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
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
