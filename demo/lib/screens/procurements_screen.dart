// TODO Implement this library.
import 'package:flutter/material.dart';

class ProcurementsScreen extends StatefulWidget {
  const ProcurementsScreen({super.key});

  @override
  State<ProcurementsScreen> createState() => _ProcurementsScreenState();
}

class _ProcurementsScreenState extends State<ProcurementsScreen> {
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
