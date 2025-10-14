import 'dart:io';
import 'package:demo/screens/VendorScreens/utils/constantdata.dart';

import '../models/product.dart';
import 'package:demo/screens/CustomerScreens/agent.dart'; // make sure the path is correct
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import '../services/api_service.dart';
import 'batch_summary_screen.dart';
import 'batch_detail_screen.dart';
import 'certificate_upload_screen.dart';

class UploadProduceScreen extends StatefulWidget {
  const UploadProduceScreen({super.key});

  @override
  State<UploadProduceScreen> createState() => _UploadProduceScreenState();
}

class _UploadProduceScreenState extends State<UploadProduceScreen> {
  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final products = await ApiService.getProducts();
      setState(() {
        _availableProducts = products;
        _isLoadingProducts = false;
      });
      _extractUniqueTypes();
    } catch (e) {
      setState(() {
        _isLoadingProducts = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Failed to load products: $e")));
    }
  }

  // Form key for validation
  final _formKey = GlobalKey<FormState>();
  final BatchFormData _formData = BatchFormData();
  final double _geoLat = 12.9716; // Bangalore latitude
  final double _geoLon = 77.5946; // Bangalore longitude
  final String _locationName = "Bangalore, India";

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _selectedCropType;
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // int _selectedRating = 5; // Default to 5 stars

  // Form state variables
  String? _selectedProductId;
  List<Product> _availableProducts = [];
  List<String> _availableTypes = [];
  List<Product> _filteredProducts = [];
  DateTime? _selectedHarvestDate;
  int _qualityRating = 5;
  String? _selectedType;

  // double? _geoLat;
  // double? _geoLon;
  // String _locationName = "Detecting location...";
  bool _isLoadingLocation = true;
  bool _isLoadingProducts = true;

  // Inside your _UploadProduceScreenState class
  void _extractUniqueTypes() {
    final types = _availableProducts.map((p) => p.type).toSet().toList();
    print("types:");
    print(types);
    print(_availableProducts.map((p) => p.type).toList());

    setState(() {
      _availableTypes = types;
      _filteredProducts = [];
      _selectedType = null;
      _selectedProductId = null;
    });
  }

  // Opens bottom sheet to choose camera or gallery
  Future<void> _showImageSourceActionSheet() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Select Photo',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.camera_alt, color: Colors.blue),
              ),
              title: const Text('Capture Photo'),
              subtitle: const Text('Take a new photo with camera'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.photo_library, color: Colors.green),
              ),
              title: const Text('Select from Gallery'),
              subtitle: const Text('Choose from existing photos'),
              onTap: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Uses ImagePicker to get image, then saves locally if from camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: source,
        maxWidth: 1200,
        maxHeight: 1200,
        imageQuality: 85,
      );

      if (picked == null) return;

      // If camera, save to app directory
      File imageFile = File(picked.path);
      if (source == ImageSource.camera) {
        final appDir = await getApplicationDocumentsDirectory();
        final fileName =
            '${DateTime.now().millisecondsSinceEpoch}_${p.basename(picked.path)}';
        imageFile = await imageFile.copy('${appDir.path}/$fileName');
      }

      setState(() {
        _selectedImage = imageFile;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error picking image: $e')));
    }
  }

  // Date picker function
  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            datePickerTheme: DatePickerThemeData(
              todayBackgroundColor: MaterialStateProperty.all(
                Colors.green.shade600,
              ), // Today circle color
              headerBackgroundColor:
                  Colors.green.shade600, // Header background color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
            "${picked.month.toString().padLeft(2, '0')}/${picked.day.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  // Handle form submission
  void _submitForm() {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a crop image'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_selectedCropType == null || _quantityController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // TODO: Implement actual upload logic here
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produce uploaded successfully!'),
        backgroundColor: Colors.green,
      ),
    );

    // Clear form
    setState(() {
      _selectedImage = null;
      _selectedCropType = null;
      _quantityController.clear();
      _notesController.clear();
      _dateController.clear();
      _qualityRating = 5;
    });
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _notesController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  void _proceedToSummary() {
    print("=== FORM DATA DEBUG ===");
    print("Selected Product ID: ${_selectedProductId ?? 'NULL'}");
    print("Form Data Product ID: ${_formData.productId ?? 'NULL'}");
    print("Form Data Product Name: '${_formData.productName}'");
    print("Quantity: ${_formData.quantity}");
    print("Harvest Date: ${_formData.harvestDate}");
    print("Is Valid: ${_formData.isValid}");
    print("========================");

    // Add null check before validation
    if (_formKey.currentState?.validate() ?? false) {
      if (_formData.isValid) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("Form is valid! Product: ${_formData.productName}"),
        //     backgroundColor: Colors.green,
        //   ),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BatchSummaryScreen(formData: _formData),
          ),
        );
      } else {
        List<String> missingFields = [];
        if (_formData.productId == null || _formData.productId!.isEmpty) {
          missingFields.add("Product not selected");
        }
        if (_formData.quantity <= 0) {
          missingFields.add("Invalid quantity");
        }
        if (_formData.harvestDate == null) {
          missingFields.add("Harvest date not set");
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Missing: ${missingFields.join(', ')}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      print("Form validation failed - form key or validation returned null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      // appBar: AppBar(
      //   title: Container(
      //     decoration: BoxDecoration(
      //       color: AppConstants.primaryGreen,
      //       boxShadow: [
      //         BoxShadow(
      //           color: Colors.green.withOpacity(0.3),
      //           blurRadius: 8,
      //           offset: const Offset(0, 2),
      //         ),
      //       ],
      //     ),
      //     child: SafeArea(
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8),
      //         child: Row(
      //           children: [
      //             const Expanded(
      //               child: Text(
      //                 "Upload Produce",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 20,
      //                   fontWeight: FontWeight.bold,
      //                   color: Colors.white,
      //                   letterSpacing: 0.5,
      //                 ),
      //               ),
      //             ),
      //             // Mic button with enhanced styling
      //             Container(
      //               decoration: BoxDecoration(
      //                 color: Colors.white.withOpacity(0.2),
      //                 shape: BoxShape.circle,
      //                 border: Border.all(
      //                   color: Colors.white.withOpacity(0.3),
      //                   width: 1,
      //                 ),
      //               ),
      //               child: IconButton(
      //                 icon: const Icon(
      //                   Icons.mic,
      //                   color: Colors.white,
      //                   size: 24,
      //                 ),
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                       builder: (context) => const AgentsPage(),
      //                     ),
      //                   );
      //                 },
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: AppConstants.primaryGreen,
        elevation: 4,
        title: Text(
          "Upload Produce",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: IconButton(
              icon: const Icon(Icons.mic, color: Colors.white, size: 24),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AgentsPage()),
                );
              },
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Upload Box with Image Preview
                // GestureDetector(
                //   onTap: _showImageSourceActionSheet,
                //   child: Container(
                //     width: double.infinity,
                //     height: 180,
                //     padding: const EdgeInsets.all(16),
                //     decoration: BoxDecoration(
                //       color: Colors.green[50],
                //       borderRadius: BorderRadius.circular(12),
                //       border: Border.all(color: Colors.green.shade100),
                //     ),
                //     child: _selectedImage == null
                //         ? const Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Icon(
                //                 Icons.camera_alt,
                //                 color: Colors.green,
                //                 size: 36,
                //               ),
                //               SizedBox(height: 8),
                //               Text(
                //                 "Tap to capture or pick photo\nYour crop photo is required",
                //                 textAlign: TextAlign.center,
                //                 style: TextStyle(color: Colors.green),
                //               ),
                //             ],
                //           )
                //         : Stack(
                //             children: [
                //               ClipRRect(
                //                 borderRadius: BorderRadius.circular(8),
                //                 child: Image.file(
                //                   _selectedImage!,
                //                   width: double.infinity,
                //                   height: double.infinity,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //               Positioned(
                //                 top: 8,
                //                 right: 8,
                //                 child: GestureDetector(
                //                   onTap: () {
                //                     setState(() {
                //                       _selectedImage = null;
                //                     });
                //                   },
                //                   child: Container(
                //                     decoration: const BoxDecoration(
                //                       color: Colors.red,
                //                       shape: BoxShape.circle,
                //                     ),
                //                     padding: const EdgeInsets.all(4),
                //                     child: const Icon(
                //                       Icons.close,
                //                       color: Colors.white,
                //                       size: 16,
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //             ],
                //           ),
                //   ),
                // ),
                const SizedBox(height: 16),
                _LabeledField(
                  label: "Select Product Type",
                  child: _isLoadingProducts
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            children: [
                              SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text("Loading products..."),
                            ],
                          ),
                        )
                      : DropdownButtonFormField<String>(
                          value: _selectedType,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          hint: const Text("Choose a product type"),
                          items: _availableTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type.toUpperCase()),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a product type';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedType = value;
                              _filteredProducts = _availableProducts
                                  .where((p) => p.type == value)
                                  .toList();
                              _selectedProductId = null;
                              _formData.selectedCategory = value;
                            });
                          },
                        ),
                ),
                const SizedBox(height: 16),

                // Add second dropdown for specific product
                _LabeledField(
                  label: "Select Specific Product",
                  child: _selectedType == null
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "Please select a product type first",
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      : DropdownButtonFormField<String>(
                          value: _selectedProductId,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                          ),
                          hint: const Text("Choose specific product"),
                          items: _filteredProducts.map((product) {
                            return DropdownMenuItem<String>(
                              value: product.id,
                              child: Text(product.name),
                            );
                          }).toList(),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please select a specific product';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() {
                              _selectedProductId = value;
                              // Find selected product details
                              final product = _filteredProducts.firstWhere(
                                (p) => p.id == value,
                                orElse: () => Product(
                                  id: '',
                                  name: '',
                                  type: '',
                                  unit: '',
                                ),
                              );
                              _formData.productId = value;
                              _formData.productName = product.name;
                              _formData.productType = product.type;
                            });

                            print(
                              "Selected product: ${_formData.productName} (${_formData.productId})",
                            );
                          },
                        ),
                ),

                const SizedBox(height: 16),

                /// Quantity
                _LabeledField(
                  label: "Quantity",
                  child: TextFormField(
                    controller: _quantityController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter quantity",
                      suffixText: "kg",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      final qty = double.tryParse(value);
                      if (qty == null || qty <= 0) {
                        return 'Please enter valid quantity';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      final qty = double.tryParse(value) ?? 0.0;
                      _formData.quantity = qty;
                    },
                  ),
                ),

                // _LabeledField(
                //   label: "Quality Grade",
                //   child: Row(
                //     children: [
                //       Row(
                //         children: List.generate(5, (index) {
                //           return GestureDetector(
                //             onTap: () {
                //               setState(() {
                //                 _qualityRating = index + 1;
                //                 _formData.qualityRating = _qualityRating;
                //               });
                //             },
                //             child: Icon(
                //               index < _qualityRating
                //                   ? Icons.star
                //                   : Icons.star_border,
                //               color: Colors.amber,
                //               size: 28,
                //             ),
                //           );
                //         }),
                //       ),
                //       const SizedBox(width: 12),
                //       Text(
                //         "$_qualityRating/5",
                //         style: const TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w500,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(height: 16),

                _LabeledField(
                  label: "Harvest Date",
                  child: GestureDetector(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 90),
                        ),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() {
                          _selectedHarvestDate = date;
                          _formData.harvestDate = date;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedHarvestDate != null
                                ? "${_selectedHarvestDate!.day}/${_selectedHarvestDate!.month}/${_selectedHarvestDate!.year}"
                                : "Select harvest date",
                            style: TextStyle(
                              color: _selectedHarvestDate != null
                                  ? Colors.black87
                                  : Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const Icon(Icons.calendar_today, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                //LOCATION
                _LabeledField(
                  label: "Location",
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _locationName,
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      Text(
                        "Lat: $_geoLat, Lon: $_geoLon",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                //BUTTON DEMO
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BatchDetailsScreen(),
                      ),
                    ),
                  },
                  child: Text("Click"),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttachCertificatePage(),
                      ),
                    ),
                  },
                  child: const Text("Upload Cert"),
                ),

                /// Buttons
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppConstants.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: _proceedToSummary,
                    child: const Text(
                      "Review & Submit Batch",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: Colors.grey),
                    ),
                    onPressed: () {
                      // TODO: Save draft functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Draft saved successfully!'),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                    child: const Text("Save as Draft"),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// --- Helper Widgets ---
class _LabeledField extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledField({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}

class _UploadTile extends StatelessWidget {
  final String image;
  final String title;
  final String time;
  final String status;
  final Color statusColor;

  const _UploadTile({
    required this.image,
    required this.title,
    required this.time,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(color: statusColor, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
