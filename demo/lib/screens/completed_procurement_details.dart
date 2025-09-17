// TODO Implement this library.
import 'package:flutter/material.dart';

class CompletedProcurementDetails extends StatefulWidget {
  const CompletedProcurementDetails({super.key});

  @override
  State<CompletedProcurementDetails> createState() =>
      _CompletedProcurementDetailsState();
}

class _CompletedProcurementDetailsState
    extends State<CompletedProcurementDetails> {
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
