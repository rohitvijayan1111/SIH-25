import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:demo/models/batch_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

const Color themeColor  =Color.fromARGB(255, 12, 131, 69);// your green

class MergeScreen extends StatefulWidget {
  final List<Batch> batches;
  const MergeScreen({Key? key, required this.batches}) : super(key: key);
  @override
  _MergeScreenState createState() => _MergeScreenState();
}

class _MergeScreenState extends State<MergeScreen> {
  Set<String> selectedBatchIds = {};
  bool isLoading = false;
  String? errorMessage;

  void toggleSelection(String id) {
    setState(() {
      if (selectedBatchIds.contains(id)) {
        selectedBatchIds.remove(id);
      } else {
        selectedBatchIds.add(id);
      }
    });
    print('Selected Batch IDs: $selectedBatchIds');
  }



  Future<void> mergeSelectedBatches() async {
    if (selectedBatchIds.length < 2) {
      setState(() {
        errorMessage = "Select at least two batches to merge.";
      });
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final baseUrl = dotenv.env['API_BASE_URL']!;
      final response = await http.post(
        Uri.parse('$baseUrl/api/batches/merge'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'batch_ids': selectedBatchIds.toList(),
          'new_batch_code': null,
        }),
      );
      if (response.statusCode == 201) {
        setState(() {
          selectedBatchIds.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Batches merged successfully')),
        );
      } else {
        setState(() {
          errorMessage = 'Merge failed: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Merge Batches',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header -- can add subtitle here if needed
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Text(
                "Select batches to merge",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 4,
                ),
                child: Text(
                  errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            // List of batches as visually improved cards
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: widget.batches.length,
                separatorBuilder: (context, i) => SizedBox(height: 14),
                itemBuilder: (context, index) {
                  var batch = widget.batches[index];
                  print("Batch #$index: id='${batch.id}', code='${batch.batchCode}'");
                  bool selected = selectedBatchIds.contains(batch.id);
                  return Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    elevation: selected ? 3 : 1,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => toggleSelection(batch.id),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: selected ? themeColor : Colors.grey[300]!,
                            width: selected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            // Placeholder for batch image/icon
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: themeColor.withOpacity(0.10),
                              child: Icon(
                                Icons.local_florist,
                                color: themeColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    batch.batchCode!,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "${batch.quantityKg} kg",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              value: selected,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              activeColor: themeColor,
                              onChanged: (_) => toggleSelection(batch.id),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    backgroundColor: themeColor,
                  ),
                  onPressed: isLoading ? null : mergeSelectedBatches,
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Merge Selected Batches',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
