// import 'dart:convert';
// import 'package:demo/screens/certificate_upload_screen.dart';
// import 'package:demo/screens/view_certificates.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// const kGreenColor = Color.fromARGB(255, 12, 131, 69);

// class BatchHistoryScreen extends StatefulWidget {
//   @override
//   State<BatchHistoryScreen> createState() => _BatchHistoryScreenState();
// }

// class _BatchHistoryScreenState extends State<BatchHistoryScreen> {
//   late Future<List<BatchItem>> batchesFuture;

//   @override
//   void initState() {
//     super.initState();
//     batchesFuture = fetchBatches();
//   }

//   Future<List<BatchItem>> fetchBatches() async {
//     final url = Uri.parse('http://localhost:3000/api/batches');
//     final response = await http.get(url);
//     if (response.statusCode == 200) {
//       final decoded = json.decode(response.body);
//       final List<dynamic> batchList = decoded["inventory"] ?? [];
//       return batchList.map((e) => BatchItem.fromJson(e)).toList();
//     } else {
//       throw Exception('Failed to fetch batches');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kGreenColor,
//         title: const Text(
//           "History",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         // leading: IconButton(
//         //   icon: Icon(Icons.arrow_back,color:Colors.white,),
//         //   onPressed: () => Navigator.of(context).maybePop(),
//         // ),
//       ),
//       body: FutureBuilder<List<BatchItem>>(
//         future: batchesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator(color: kGreenColor));
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final batches = snapshot.data ?? [];
//           return ListView.builder(
//             padding: const EdgeInsets.all(12),
//             itemCount: batches.length,
//             itemBuilder: (context, idx) {
//               final b = batches[idx];
//               return BatchHistoryCard(batch: b);
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class BatchItem {
//   final String batchId;
//   final String batchCode;
//   final String productName;
//   final String productType;
//   final String farmerName;
//   final String locationName;
//   final int batchQuantity;
//   final String unit;
//   final String harvestDate;
//   // Add more fields as needed

//   BatchItem({
//     required this.batchId,
//     required this.batchCode,
//     required this.productName,
//     required this.productType,
//     required this.farmerName,
//     required this.locationName,
//     required this.batchQuantity,
//     required this.unit,
//     required this.harvestDate,
//   });

//   factory BatchItem.fromJson(Map<String, dynamic> map) => BatchItem(
//     batchId: map['batch_id'] ?? '',
//     batchCode: map['batch_code'] ?? '',
//     productName: map['product_name'] ?? '',
//     productType: map['product_type'] ?? '',
//     farmerName: map['farmer_name'] ?? '',
//     locationName: map['location_name'] ?? '',
//     batchQuantity: map['batch_quantity'] is int
//         ? map['batch_quantity']
//         : int.tryParse('${map['batch_quantity'] ?? '0'}') ?? 0,
//     unit: map['unit'] ?? '',
//     harvestDate: map['harvest_date'] ?? '',
//   );
// }

// class BatchHistoryCard extends StatelessWidget {
//   final BatchItem batch;
//   const BatchHistoryCard({required this.batch});

//   @override
//   Widget build(BuildContext context) {
//     DateTime? harvested;
//     try {
//       harvested = DateTime.parse(batch.harvestDate);
//     } catch (_) {}
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//       margin: const EdgeInsets.only(bottom: 16),
//       child: Padding(
//         padding: const EdgeInsets.all(12),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top Row: Placeholder for the image, batch code
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Placeholder: Container for image
//                 Container(
//                   height: 64,
//                   width: 64,
//                   decoration: BoxDecoration(
//                     color: Colors.grey[200],
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(Icons.image, size: 32, color: Colors.grey[400]),
//                 ),
//                 SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Batch code/tag
//                       Container(
//                         decoration: BoxDecoration(
//                           color: kGreenColor.withOpacity(0.12),
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           vertical: 2,
//                           horizontal: 6,
//                         ),
//                         child: Text(
//                           batch.batchCode,
//                           style: TextStyle(
//                             color: kGreenColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         batch.productName,
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       Text(
//                         batch.productType,
//                         style: TextStyle(color: Colors.grey[700], fontSize: 12),
//                       ),
//                       // Right aligned time-to-now/placeholder
//                       Align(
//                         alignment: Alignment.topRight,
//                         child: Text(
//                           harvested != null
//                               ? '${DateTime.now().difference(harvested).inDays} days ago'
//                               : '',
//                           style: TextStyle(
//                             color: Colors.grey[500],
//                             fontSize: 11,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),

//             SizedBox(height: 10),
//             Row(
//               children: [
//                 _InfoBox(
//                   value: '${batch.batchQuantity} ${batch.unit}',
//                   label: 'Quantity',
//                 ),
//                 SizedBox(width: 10),
//                 _InfoBox(
//                   value:
//                       'Grade A', // Placeholder, update if you have grade data!
//                   label: 'Grade',
//                 ),
//               ],
//             ),
//             SizedBox(height: 10),

//             Row(
//               children: [
//                 Icon(Icons.calendar_month, color: kGreenColor, size: 18),
//                 SizedBox(width: 5),
//                 Text(
//                   harvested != null
//                       ? 'Harvested: ${_formatDate(harvested)}'
//                       : 'Harvest date missing',
//                   style: TextStyle(fontSize: 12),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Icon(Icons.location_on, color: kGreenColor, size: 16),
//                 SizedBox(width: 5),
//                 Flexible(
//                   child: Text(
//                     batch.locationName,
//                     style: TextStyle(fontSize: 12, color: Colors.black87),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(height: 8),

//             // View certificates, Add button placeholders
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 TextButton.icon(
//                   style: TextButton.styleFrom(
//                     padding: EdgeInsets.zero,
//                     minimumSize: Size(0, 20),
//                   ),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => ViewCertificates(
//                           batchId: 'af7df286-383c-44d1-8132-5f523c3e1cbe',
//                         ),
//                       ),
//                     );
//                   }, // Add certificate logic
//                   icon: Icon(
//                     Icons.insert_drive_file,
//                     size: 18,
//                     color: kGreenColor,
//                   ),
//                   label: Text(
//                     'View Certificates (5)', // Hardcoded for now
//                     style: TextStyle(color: kGreenColor, fontSize: 13),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.add_circle, color: kGreenColor),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             AttachCertificatePage(), // Replace with your screen widget
//                       ),
//                     );
//                   }, // Add button logic
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(DateTime dt) {
//     return '${dt.day.toString().padLeft(2, '0')} ${_monthName(dt.month)} ${dt.year}';
//   }

//   String _monthName(int m) {
//     const months = [
//       '',
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec',
//     ];
//     return months[m];
//   }
// }

// class _InfoBox extends StatelessWidget {
//   final String value;
//   final String label;
//   const _InfoBox({required this.value, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: 8, horizontal: 2),
//         decoration: BoxDecoration(
//           color: Colors.green[50],
//           borderRadius: BorderRadius.circular(6),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               value,
//               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
//             ),
//             SizedBox(height: 2),
//             Text(
//               label,
//               style: TextStyle(fontSize: 11, color: Colors.green[800]),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:demo/screens/certificate_upload_screen.dart';
import 'package:demo/screens/view_certificates.dart';
import 'package:demo/services/batch_service.dart';
import 'package:demo/models/batch_model.dart';
import 'package:flutter/material.dart';
import './VendorScreens/utils/constantdata.dart';

const kGreenColor = AppConstants.primaryGreen;

class BatchHistoryScreen extends StatefulWidget {
  @override
  State<BatchHistoryScreen> createState() => _BatchHistoryScreenState();
}

class _BatchHistoryScreenState extends State<BatchHistoryScreen> {
  late Future<List<BatchHistoryItem>> batchesFuture;
  String _searchQuery = '';
  String _statusFilter = 'ALL';

  @override
  void initState() {
    super.initState();
    batchesFuture = BatchService.getAllBatches();
  }

  Future<void> _refreshData() async {
    setState(() {
      batchesFuture = BatchService.getAllBatches();
    });
  }

  List<BatchHistoryItem> _filterBatches(List<BatchHistoryItem> batches) {
    return batches.where((batch) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          batch.productName.toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          batch.batchCode.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          batch.farmerName.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesStatus =
          _statusFilter == 'ALL' || batch.status.toUpperCase() == _statusFilter;

      return matchesSearch && matchesStatus;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreenColor,
        title: const Text(
          "Batch History",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Colors.white),
            onPressed: _refreshData,
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: Column(
        children: [
          // Search and Filter Section
          Container(
            color: kGreenColor,
            padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Column(
              children: [
                // Search Bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search batches...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 12),
                // Status Filter
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ['ALL', 'PENDING', 'VERIFIED', 'LISTED', 'LOCKED']
                        .map(
                          (status) => Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(status),
                              selected: _statusFilter == status,
                              onSelected: (selected) {
                                setState(() {
                                  _statusFilter = status;
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),

          // Batch List
          Expanded(
            child: RefreshIndicator(
              color: kGreenColor,
              onRefresh: _refreshData,
              child: FutureBuilder<List<BatchHistoryItem>>(
                future: batchesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(color: kGreenColor),
                    );
                  } else if (snapshot.hasError) {
                    return _buildErrorState(snapshot.error.toString());
                  }

                  final allBatches = snapshot.data ?? [];
                  final filteredBatches = _filterBatches(allBatches);

                  if (allBatches.isEmpty) {
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredBatches.length,
                    itemBuilder: (context, idx) {
                      return BatchHistoryCard(batch: filteredBatches[idx]);
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red),
          SizedBox(height: 16),
          Text(
            'Error loading batches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            error,
            style: TextStyle(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _refreshData,
            icon: Icon(Icons.refresh),
            label: Text('Try Again'),
            style: ElevatedButton.styleFrom(backgroundColor: kGreenColor),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No batches found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'There are no batches in your history yet.',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class BatchHistoryCard extends StatelessWidget {
  final BatchHistoryItem batch;

  const BatchHistoryCard({required this.batch});

  @override
  Widget build(BuildContext context) {
    // Status color mapping
    Color statusColor = _getStatusColor(batch.status);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: kGreenColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    batch.batchCode,
                    style: TextStyle(
                      color: kGreenColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    batch.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 11,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Product Info
            Text(
              batch.productName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              batch.productType,
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            SizedBox(height: 8),

            // Quantity and Price
            Row(
              children: [
                // _InfoChip(
                //   icon: Icons.inventory,
                //   text:
                //       '${batch.currentQuantity}/${batch.initialQuantity} ${batch.unit}',
                // ),
                SizedBox(width: 8),
                _InfoChip(
                  icon: Icons.currency_rupee,
                  text: '${batch.pricePerUnit.toStringAsFixed(2)}',
                ),
              ],
            ),

            SizedBox(height: 8),

            // Location
            Row(
              children: [
                Icon(Icons.location_on, color: kGreenColor, size: 16),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    batch.locationName,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // View Certificates Button - USES REAL BATCH ID
                FutureBuilder<int>(
                  future: BatchService.getCertificateCount(batch.batchId),
                  builder: (context, snapshot) {
                    int certCount = snapshot.data ?? 0;
                    return TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewCertificates(
                              batchId: batch.batchId, // REAL BATCH ID!
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.verified_user,
                        size: 16,
                        color: kGreenColor,
                      ),
                      label: Text(
                        'Certificates ($certCount)',
                        style: TextStyle(color: kGreenColor, fontSize: 12),
                      ),
                    );
                  },
                ),

                // Add Certificate Button
                IconButton(
                  icon: Icon(Icons.add_circle_outline, color: kGreenColor),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttachCertificatePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'VERIFIED':
        return Colors.green;
      case 'PENDING':
        return Colors.orange;
      case 'LOCKED':
        return Colors.red;
      case 'LISTED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoChip({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: kGreen,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kGreen!),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
