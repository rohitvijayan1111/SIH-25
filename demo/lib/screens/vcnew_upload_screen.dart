import 'dart:io';
import '../models/product.dart';
import 'package:demo/screens/CustomerScreens/agent.dart'; // make sure the path is correct
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';


class UploadProduceScreen extends StatefulWidget {
  const UploadProduceScreen({super.key});

  @override
  State<UploadProduceScreen> createState() => _UploadProduceScreenState();
}

class _UploadProduceScreenState extends State<UploadProduceScreen> {
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
  DateTime? _selectedHarvestDate;
  int _qualityRating = 5;
  // double? _geoLat;
  // double? _geoLon;
  // String _locationName = "Detecting location...";
  bool _isLoadingLocation = true;
  bool _isLoadingProducts = true;

  // Inside your _UploadProduceScreenState class

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
            colorScheme: ColorScheme.light(
              primary: Colors.green.shade600,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.green.shade600, Colors.green.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      "Upload Produce",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  // Mic button with enhanced styling
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.mic,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AgentsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Upload Box with Image Preview
              GestureDetector(
                onTap: _showImageSourceActionSheet,
                child: Container(
                  width: double.infinity,
                  height: 180,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade100),
                  ),
                  child: _selectedImage == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              color: Colors.green,
                              size: 36,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Tap to capture or pick photo\nYour crop photo is required",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.green),
                            ),
                          ],
                        )
                      : Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _selectedImage!,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedImage = null;
                                  });
                                },
                                child: Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  child: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),

              /// Crop Type Dropdown
              _LabeledField(
                label: "Crop Type *",
                child: DropdownButtonFormField<String>(
                  value: _selectedCropType,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    isDense: true,
                    hintText: "Select crop type",
                  ),
                  items: const [
                    DropdownMenuItem(value: "Rice", child: Text("Rice")),
                    DropdownMenuItem(value: "Wheat", child: Text("Wheat")),
                    DropdownMenuItem(value: "Tomato", child: Text("Tomato")),
                    DropdownMenuItem(value: "Corn", child: Text("Corn")),
                    DropdownMenuItem(value: "Potato", child: Text("Potato")),
                    DropdownMenuItem(value: "Onion", child: Text("Onion")),
                  ],
                  onChanged: (val) {
                    setState(() {
                      _selectedCropType = val;
                    });
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

              /// Quality Grade with Interactive Stars
              // _LabeledField(
              //   label: "Quality Grade",
              //   child: Row(
              //     children: [
              //       ...List.generate(5, (index) {
              //         return GestureDetector(
              //           onTap: () {
              //             setState(() {
              //               _qualityRating = index + 1;
              //             });
              //           },
              //           child: Padding(
              //             padding: const EdgeInsets.only(right: 4),
              //             child: Icon(
              //               Icons.star,
              //               color: index < _qualityRating
              //                   ? Colors.amber
              //                   : Colors.grey[300],
              //               size: 32,
              //             ),
              //           ),
              //         );
              //       }),
              //       const SizedBox(width: 8),
              //       Text(
              //         "$_qualityRating/5",
              //         style: TextStyle(
              //           color: Colors.grey[600],
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              _LabeledField(
                label: "Quality Grade",
                child: Row(
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _qualityRating = index + 1;
                              _formData.qualityRating = _qualityRating;
                            });
                          },
                          child: Icon(
                            index < _qualityRating
                                ? Icons.star
                                : Icons.star_border,
                            color: Colors.amber,
                            size: 28,
                          ),
                        );
                      }),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$_qualityRating/5",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              /// Harvest Date with Date Picker
              // _LabeledField(
              //   label: "Harvest Date",
              //   child: TextFormField(
              //     controller: _dateController,
              //     readOnly: true,
              //     onTap: _selectDate,
              //     decoration: const InputDecoration(
              //       border: OutlineInputBorder(),
              //       hintText: "mm/dd/yyyy",
              //       suffixIcon: Icon(Icons.calendar_today),
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 16),
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

              /// GPS Location
              // _LabeledField(
              //   label: "GPS Location",
              //   child: Container(
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 12,
              //       vertical: 14,
              //     ),
              //     decoration: BoxDecoration(
              //       color: Colors.green[50],
              //       border: Border.all(color: Colors.green.shade200),
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //     child: Row(
              //       children: [
              //         const Expanded(
              //           child: Text(
              //             "Auto-detected\nFarm location, Dhaka",
              //             style: TextStyle(color: Colors.black87, fontSize: 13),
              //           ),
              //         ),
              //         TextButton(
              //           onPressed: () {
              //             // TODO: Implement location editing
              //             ScaffoldMessenger.of(context).showSnackBar(
              //               const SnackBar(
              //                 content: Text(
              //                   'Location editing feature coming soon!',
              //                 ),
              //               ),
              //             );
              //           },
              //           style: TextButton.styleFrom(
              //             backgroundColor: Colors.green[100],
              //             padding: const EdgeInsets.symmetric(horizontal: 12),
              //           ),
              //           child: const Text(
              //             "Edit",
              //             style: TextStyle(color: Colors.green),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),

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

              /// Buttons
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: _submitForm,
                  child: const Text(
                    "+ Add Produce",
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
