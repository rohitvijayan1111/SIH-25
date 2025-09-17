// TODO Implement this library.
import 'package:flutter/material.dart';

class CreateProcurementScreen extends StatefulWidget {
  const CreateProcurementScreen({super.key});

  @override
  State<CreateProcurementScreen> createState() =>
      _CreateProcurementScreenState();
}

class _CreateProcurementScreenState extends State<CreateProcurementScreen> {
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
