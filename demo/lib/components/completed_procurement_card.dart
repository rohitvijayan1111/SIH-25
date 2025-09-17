// TODO Implement this library.
import 'package:flutter/material.dart';

class CompletedProcurementCard extends StatefulWidget {
  const CompletedProcurementCard({super.key});

  @override
  State<CompletedProcurementCard> createState() =>
      _CompletedProcurementCardState();
}

class _CompletedProcurementCardState extends State<CompletedProcurementCard> {
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
