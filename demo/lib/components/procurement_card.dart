// TODO Implement this library.
import 'package:flutter/material.dart';

class ProcurementCard extends StatefulWidget {
  const ProcurementCard({super.key});

  @override
  State<ProcurementCard> createState() => _ProcurementCardState();
}

class _ProcurementCardState extends State<ProcurementCard> {
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
