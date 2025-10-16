import 'package:flutter/material.dart';

import '../../services/batch_service.dart';
import './purchase_screen.dart';
import '../../models/batch_model.dart';

class BatchListScreen extends StatefulWidget {
  final String productName;

  const BatchListScreen({Key? key, required this.productName})
    : super(key: key);

  @override
  _BatchListScreenState createState() => _BatchListScreenState();
}

class _BatchListScreenState extends State<BatchListScreen> {
  List<Batch> batches = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    loadBatches();
  }

  Future<void> loadBatches() async {
    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final fetchedBatches = await BatchService.getBatchesByProductName(
        widget.productName,
      );
      setState(() {
        batches = fetchedBatches;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = "Couldn't fetch";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF1E40AF),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Available Supplies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: loadBatches,
          ),
        ],
      ),
      body: Column(
        children: [
          // Header Info
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Color(0xFF1E40AF).withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.productName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E40AF),
                  ),
                ),
                if (!isLoading && batches.isNotEmpty)
                  Text(
                    '${batches.length} farmer${batches.length != 1 ? 's' : ''} available',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(color: Color(0xFF1E40AF)),
                  )
                : error != null
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, size: 64, color: Colors.red),
                        SizedBox(height: 16),
                        Text("Couldn't fetch"),
                        SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: loadBatches,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF1E40AF),
                          ),
                          child: Text(
                            'Retry',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  )
                : batches.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2, size: 64, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('No supplies available'),
                        Text('for ${widget.productName}'),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: loadBatches,
                    color: Color(0xFF1E40AF),
                    child: ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: batches.length,
                      itemBuilder: (context, index) {
                        final batch = batches[index];
                        return _buildBatchCard(batch);
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildBatchCard(Batch batch) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Farmer Header
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Color(0xFF1E40AF).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      (batch.farmerName?.isNotEmpty == true)
                          ? batch.farmerName![0].toUpperCase()
                          : 'F',
                      style: TextStyle(
                        color: Color(0xFF1E40AF),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        batch.farmerName ?? 'Unknown Farmer',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      if (batch.farmerLocation != null)
                        Text(
                          batch.farmerLocation!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
                // Rating placeholder
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      '4.7',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 12),

            // Certifications
            if (batch.certifications != null &&
                batch.certifications!.isNotEmpty)
              Wrap(
                spacing: 8,
                children: batch.certifications!
                    .split(',')
                    .map(
                      (cert) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          cert.trim(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.green,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

            SizedBox(height: 12),

            // Availability info
            Text(
              'Available: ${batch.availableQty}${batch.unit} at ₹${batch.pricePerUnit.toStringAsFixed(0)}/${batch.unit}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),

            if (batch.harvestDate != null) ...[
              SizedBox(height: 8),
              Text(
                'Harvested: ${_formatDate(batch.harvestDate!)}',
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],

            SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PurchaseScreen(batch: batch),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Buy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                // Expanded(
                //   child: OutlinedButton(
                //     onPressed: () {
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Counter-offer feature coming soon')),
                //       );
                //     },
                //     style: OutlinedButton.styleFrom(
                //       side: BorderSide(color: Color(0xFF1E40AF)),
                //       padding: EdgeInsets.symmetric(vertical: 12),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //     child: Text(
                //       'Counter-offer',
                //       style: TextStyle(
                //         color: Color(0xFF1E40AF),
                //         fontWeight: FontWeight.w500,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),

            SizedBox(height: 8),

            // Negotiation Chat
            // Center(
            //   child: TextButton(
            //     onPressed: () {
            //       ScaffoldMessenger.of(context).showSnackBar(
            //         SnackBar(content: Text('Chat feature coming soon')),
            //       );
            //     },
            //     child: Text(
            //       'Open negotiation chat',
            //       style: TextStyle(color: Color(0xFF1E40AF), fontSize: 12),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    List<String> months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
