// File: lib/screens/middleman/procurement/procurement_screen.dart
// Purpose: Main procurement screen with tabs for Active Requests, Create Request, and Bidding

import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import './active_requests_tab.dart';
import './create_request_tab.dart';
import './bidding_tab.dart';

class ProcurementScreen extends StatefulWidget {
  final int initialTab;

  const ProcurementScreen({Key? key, this.initialTab = 0}) : super(key: key);

  @override
  State<ProcurementScreen> createState() => _ProcurementScreenState();
}

class _ProcurementScreenState extends State<ProcurementScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTab,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppConstants.primaryBlue,
        elevation: 0,
        title: const Row(
          children: [
            SizedBox(width: 8),
            const Text(
              'Procurement',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [ActiveRequestsTab(), CreateRequestTab()],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                _tabController.animateTo(1);
              },
              backgroundColor: AppConstants.primaryBlue,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'Create Procurement',
                style: TextStyle(color: Colors.white),
              ),
            )
          : null,
    );
  }
}
