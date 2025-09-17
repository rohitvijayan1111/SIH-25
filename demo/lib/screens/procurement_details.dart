// TODO Implement this library.
import 'package:flutter/material.dart';

class ProcurementDetails extends StatefulWidget {
  const ProcurementDetails({super.key});

  @override
  State<ProcurementDetails> createState() => _ProcurementDetailsState();
}

class _ProcurementDetailsState extends State<ProcurementDetails> {
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
