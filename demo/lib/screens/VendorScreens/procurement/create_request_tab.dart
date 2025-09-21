import 'package:flutter/material.dart';
import '../utils/constantdata.dart';
import '../utils/sample_data.dart';
import '../models/product.dart';

class CreateRequestTab extends StatefulWidget {
  const CreateRequestTab({Key? key}) : super(key: key);

  @override
  State<CreateRequestTab> createState() => _CreateRequestTabState();
}

class _CreateRequestTabState extends State<CreateRequestTab> {
  final _formKey = GlobalKey<FormState>();
  final _quantityController = TextEditingController();
  final _maxPriceController = TextEditingController();
  final _deliveryLocationController = TextEditingController();
  final _specialRequirementsController = TextEditingController();

  Product? _selectedProduct;
  String? _selectedVariety;
  DateTime? _selectedDeadline;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _quantityController.dispose();
    _maxPriceController.dispose();
    _deliveryLocationController.dispose();
    _specialRequirementsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: AppConstants.largePadding),
            _buildProductSelection(),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildQuantityInput(),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildMaxPriceInput(),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildDeadlineSelection(),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildDeliveryLocationInput(),
            const SizedBox(height: AppConstants.defaultPadding),
            _buildSpecialRequirementsInput(),
            const SizedBox(height: AppConstants.largePadding),
            _buildSubmitButton(),
            const SizedBox(height: AppConstants.defaultPadding),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(AppConstants.defaultPadding),
      decoration: BoxDecoration(
        color: AppConstants.primaryBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.cardBorderRadius),
        border: Border.all(color: AppConstants.primaryBlue.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppConstants.primaryBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.add_shopping_cart,
              color: AppConstants.primaryBlue,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create Procurement Request',
                  style: TextStyle(
                    fontSize: AppConstants.subtitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.primaryBlue,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Fill in the details to create a new procurement request',
                  style: TextStyle(
                    fontSize: AppConstants.captionFontSize + 1,
                    color: AppConstants.darkGrey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Selection *',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Product>(
          value: _selectedProduct,
          decoration: InputDecoration(
            hintText: 'Select product',
            prefixIcon: const Icon(Icons.agriculture),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          items: SampleData.products.map((product) {
            return DropdownMenuItem<Product>(
              value: product,
              child: Row(
                children: [
                  Text(product.imageUrl, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(product.name),
                ],
              ),
            );
          }).toList(),
          onChanged: (Product? product) {
            setState(() {
              _selectedProduct = product;
              _selectedVariety = null;
            });
          },
          validator: (value) {
            if (value == null) {
              return 'Please select a product';
            }
            return null;
          },
        ),
        if (_selectedProduct != null) ...[
          const SizedBox(height: 12),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Variety (Optional)',
              hintText: 'e.g., Roma, Basmati, etc.',
              prefixIcon: const Icon(Icons.label),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  AppConstants.defaultBorderRadius,
                ),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            onChanged: (value) {
              _selectedVariety = value;
            },
          ),
        ],
      ],
    );
  }

  Widget _buildQuantityInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity Required *',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _quantityController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter quantity in kg',
            prefixIcon: const Icon(Icons.scale),
            suffixText: 'kg',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter quantity';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid number';
            }
            if (double.parse(value) <= 0) {
              return 'Quantity must be greater than 0';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildMaxPriceInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Maximum Price per Kg *',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _maxPriceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter max price',
            prefixIcon: const Icon(Icons.currency_rupee),
            suffixText: '/kg',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter maximum price';
            }
            if (double.tryParse(value) == null) {
              return 'Please enter a valid price';
            }
            if (double.parse(value) <= 0) {
              return 'Price must be greater than 0';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildDeadlineSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deadline *',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: _selectDeadline,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[400]!),
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
              color: Colors.grey[50],
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.grey),
                const SizedBox(width: 12),
                Text(
                  _selectedDeadline != null
                      ? AppUtils.formatDate(_selectedDeadline!)
                      : 'Select deadline',
                  style: TextStyle(
                    fontSize: AppConstants.bodyFontSize,
                    color: _selectedDeadline != null
                        ? Colors.black87
                        : Colors.grey[600],
                  ),
                ),
                const Spacer(),
                const Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeliveryLocationInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Delivery Location *',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _deliveryLocationController,
          decoration: InputDecoration(
            hintText: 'Enter delivery location',
            prefixIcon: const Icon(Icons.location_on),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter delivery location';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSpecialRequirementsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Special Requirements (Optional)',
          style: TextStyle(
            fontSize: AppConstants.bodyFontSize,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _specialRequirementsController,
          maxLines: 3,
          decoration: InputDecoration(
            hintText: 'Any specific requirements or notes...',
            prefixIcon: const Icon(Icons.note, size: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                AppConstants.defaultBorderRadius,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSubmitting ? null : _submitProcurementRequest,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppConstants.primaryBlue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.defaultBorderRadius,
            ),
          ),
        ),
        child: _isSubmitting
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send, size: 20),
                  SizedBox(width: 8),
                  Text(
                    'Create Procurement Request',
                    style: TextStyle(
                      fontSize: AppConstants.bodyFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _selectDeadline() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppConstants.primaryBlue,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDeadline = picked;
      });
    }
  }

  void _submitProcurementRequest() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_selectedDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a deadline'),
          backgroundColor: AppConstants.errorRed,
        ),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isSubmitting = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Procurement request created successfully!'),
        backgroundColor: AppConstants.primaryGreen,
      ),
    );

    _resetForm();
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _quantityController.clear();
    _maxPriceController.clear();
    _deliveryLocationController.clear();
    _specialRequirementsController.clear();
    setState(() {
      _selectedProduct = null;
      _selectedVariety = null;
      _selectedDeadline = null;
    });
  }
}
