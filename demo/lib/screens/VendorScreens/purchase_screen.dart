//NEW
// screens/purchase_screen.dart
import 'package:flutter/material.dart';
import '../../models/batch_model.dart';
import '../../services/purchase_service.dart';
import '../../services/batch_service.dart';

class PurchaseScreen extends StatefulWidget {
  final Batch batch;

  const PurchaseScreen({Key? key, required this.batch}) : super(key: key);

  @override
  _PurchaseScreenState createState() => _PurchaseScreenState();
}

class _PurchaseScreenState extends State<PurchaseScreen> {
  int selectedQuantity = 1;
  late int maxQuantity;
  bool isCreatingPurchase = false;

  @override
  void initState() {
    super.initState();
    maxQuantity = widget.batch.availableQty;
    // selectedQuantity = maxQuantity > 100 ? 100 : maxQuantity;
    selectedQuantity = 1;
  }

  double get totalPrice => selectedQuantity * widget.batch.pricePerUnit;

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
          'Purchase: ${widget.batch.productName}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Color(0xFF1E40AF).withOpacity(0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.batch.productName ?? 'Unknown Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${widget.batch.pricePerUnit.toStringAsFixed(0)}/${widget.batch.unit ?? 'kg'}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Available Now',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Farmer Info Section
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Farmer Details',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            (widget.batch.farmerName?.isNotEmpty == true)
                                ? widget.batch.farmerName![0].toUpperCase()
                                : 'F',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.batch.farmerName ?? 'Unknown Farmer',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (widget.batch.farmerLocation != null)
                              Text(
                                widget.batch.farmerLocation!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Product Details
                  Text(
                    'Available: ${widget.batch.availableQty}${widget.batch.unit ?? 'kg'} at ₹${widget.batch.pricePerUnit.toStringAsFixed(0)}/${widget.batch.unit ?? 'kg'}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),

                  if (widget.batch.harvestDate != null) ...[
                    SizedBox(height: 8),
                    Text(
                      'Harvested: ${_formatDate(widget.batch.harvestDate!)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Quantity Selection
            // Container(
            //   margin: EdgeInsets.symmetric(horizontal: 16),
            //   padding: EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(color: Colors.grey.shade200),
            //   ),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'Select Quantity',
            //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //       ),
            //       SizedBox(height: 16),
            //       Row(
            //         children: [
            //           IconButton(
            //             onPressed: selectedQuantity > 1
            //                 ? () {
            //                     setState(() {
            //                       selectedQuantity--;
            //                     });
            //                   }
            //                 : null,
            //             icon: Icon(Icons.remove),
            //             style: IconButton.styleFrom(
            //               backgroundColor: Colors.grey.shade100,
            //             ),
            //           ),
            //           SizedBox(width: 16),
            //           Expanded(
            //             child: TextFormField(
            //               controller: TextEditingController(
            //                 text: selectedQuantity.toString(),
            //               ),
            //               keyboardType: TextInputType.number,
            //               textAlign: TextAlign.center,
            //               decoration: InputDecoration(
            //                 border: OutlineInputBorder(),
            //                 contentPadding: EdgeInsets.symmetric(vertical: 12),
            //               ),
            //               onChanged: (value) {
            //                 int? newValue = int.tryParse(value);
            //                 if (newValue != null &&
            //                     newValue > 0 &&
            //                     newValue <= maxQuantity) {
            //                   setState(() {
            //                     selectedQuantity = newValue;
            //                   });
            //                 }
            //               },
            //             ),
            //           ),
            //           SizedBox(width: 16),
            //           IconButton(
            //             onPressed: selectedQuantity < maxQuantity
            //                 ? () {
            //                     setState(() {
            //                       selectedQuantity++;
            //                     });
            //                   }
            //                 : null,
            //             icon: Icon(Icons.add),
            //             style: IconButton.styleFrom(
            //               backgroundColor: Colors.grey.shade100,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 8),
            //       Center(
            //         child: Text(
            //           '${widget.batch.unit ?? 'kg'} (Max: ${maxQuantity}${widget.batch.unit ?? 'kg'})',
            //           style: TextStyle(
            //             fontSize: 12,
            //             color: Colors.grey.shade600,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Quantity',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 16),

                  // Single unit increment/decrement row
                  Row(
                    children: [
                      IconButton(
                        onPressed: selectedQuantity > 1
                            ? () {
                                setState(() {
                                  selectedQuantity--;
                                });
                              }
                            : null,
                        icon: Icon(Icons.remove),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: selectedQuantity.toString(),
                          ),
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                          ),
                          onChanged: (value) {
                            int? newValue = int.tryParse(value);
                            if (newValue != null &&
                                newValue > 0 &&
                                newValue <= maxQuantity) {
                              setState(() {
                                selectedQuantity = newValue;
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      IconButton(
                        onPressed: selectedQuantity < maxQuantity
                            ? () {
                                setState(() {
                                  selectedQuantity++;
                                });
                              }
                            : null,
                        icon: Icon(Icons.add),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade100,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16),

                  // Ten unit increment/decrement row
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: selectedQuantity >= 10
                              ? () {
                                  setState(() {
                                    selectedQuantity -= 10;
                                    // Ensure we don't go below 1
                                    if (selectedQuantity < 1) {
                                      selectedQuantity = 1;
                                    }
                                  });
                                }
                              : null, // Disabled when less than 10
                          icon: Icon(Icons.remove_circle_outline),
                          label: Text('-10'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: selectedQuantity >= 10
                                ? Colors.red.shade50
                                : Colors.grey.shade100,
                            foregroundColor: selectedQuantity >= 10
                                ? Colors.red.shade700
                                : Colors.grey.shade500,
                            side: BorderSide(
                              color: selectedQuantity >= 10
                                  ? Colors.red.shade200
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: (selectedQuantity + 10) <= maxQuantity
                              ? () {
                                  setState(() {
                                    selectedQuantity += 10;
                                  });
                                }
                              : null, // Disabled when adding 10 would exceed max
                          icon: Icon(Icons.add_circle_outline),
                          label: Text('+10'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                (selectedQuantity + 10) <= maxQuantity
                                ? Colors.green.shade50
                                : Colors.grey.shade100,
                            foregroundColor:
                                (selectedQuantity + 10) <= maxQuantity
                                ? Colors.green.shade700
                                : Colors.grey.shade500,
                            side: BorderSide(
                              color: (selectedQuantity + 10) <= maxQuantity
                                  ? Colors.green.shade200
                                  : Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      '${widget.batch.unit ?? 'kg'} (Max: ${maxQuantity}${widget.batch.unit ?? 'kg'})',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80), // Space for bottom bar
          ],
        ),
      ),

      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 4,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Cost',
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                  Text(
                    '₹${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: isCreatingPurchase
                    ? null
                    : () {
                        _showPurchaseConfirmation();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: isCreatingPurchase
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Purchase',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPurchaseConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Confirm Purchase'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Product: ${widget.batch.productName}'),
            Text('Farmer: ${widget.batch.farmerName}'),
            Text('Quantity: ${selectedQuantity}${widget.batch.unit ?? 'kg'}'),
            Text('Total: ₹${totalPrice.toStringAsFixed(2)}'),
            SizedBox(height: 16),
            Text(
              'This will create a purchase order in the system.',
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context); // Close dialog
              await _createPurchase();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: Text(
              'Confirm Purchase',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  // Future<void> _createPurchase() async {
  //   setState(() {
  //     isCreatingPurchase = true;
  //   });

  //   try {
  //     // You'll need to get the actual middleman_id from your auth/session
  //     // For now, using a placeholder - replace with actual implementation
  //     String middlemanId =
  //         'c66d30f4-3517-431f-ba4f-dcca7c85b22c'; // Replace with actual middleman ID

  //     bool success = await PurchaseService.createPurchase(
  //       middlemanId: middlemanId,
  //       farmerId: widget.batch.farmerId,
  //       batchId: widget.batch.id,
  //       productId: widget.batch.productId,
  //       quantityKg: selectedQuantity,
  //       pricePerKg: widget.batch.pricePerUnit,
  //       paymentMode: 'UPI',
  //     );

  //     if (success) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Purchase order created successfully!'),
  //           backgroundColor: Colors.green,
  //         ),
  //       );

  //       // Navigate back to batch list or previous screen
  //       Navigator.of(
  //         context,
  //       ).popUntil((route) => route.settings.name != '/purchase');
  //     } else {
  //       throw Exception('Purchase creation failed');
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to create purchase: ${e.toString()}'),
  //         backgroundColor: Colors.red,
  //       ),
  //     );
  //   } finally {
  //     if (mounted) {
  //       setState(() {
  //         isCreatingPurchase = false;
  //       });
  //     }
  //   }
  // }

  Future<void> _createPurchase() async {
    setState(() {
      isCreatingPurchase = true;
    });

    try {
      // 1️⃣ First, perform the split using same details
      bool splitSuccess = await BatchService.splitBatchBeforePurchase(
        batchId: widget.batch.id,
        splitQty: selectedQuantity,
        unit: widget.batch.unit ?? 'KG',
      );

      if (!splitSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to split batch. Please check stock.")),
        );
        setState(() => isCreatingPurchase = false);
        return;
      }

      // 2️⃣ Continue with the purchase call using same batch details
      bool purchaseSuccess = await PurchaseService.createPurchase(
        middlemanId: 'c66d30f4-3517-431f-ba4f-dcca7c85b22c',
        farmerId: widget.batch.farmerId,
        batchId: widget.batch.id,
        productId: widget.batch.productId,
        quantityKg: selectedQuantity,
        pricePerKg: widget.batch.pricePerUnit,
        paymentMode: 'UPI',
      );

      // 3️⃣ Show same success result in the existing UI context
      if (purchaseSuccess) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Purchase Successful!")));
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Purchase failed!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: ${e.toString()}")));
    } finally {
      setState(() => isCreatingPurchase = false);
    }
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
