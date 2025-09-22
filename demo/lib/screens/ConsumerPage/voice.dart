import 'package:flutter/material.dart';

class AgentsPage extends StatefulWidget {
  const AgentsPage({Key? key}) : super(key: key);

  @override
  State<AgentsPage> createState() => _AgentsPageState();
}

class _AgentsPageState extends State<AgentsPage> {
  String selectedLanguage = "Tamil (தமிழ்)";
  final List<String> languages = ["Tamil (தமிழ்)", "English", "Hindi"];

  // Mock produce history
  final List<Map<String, String>> produceHistory = [
    {"name": "Tomatoes", "details": "50 kg • ₹25/kg • 2 days ago"},
    {"name": "Onions", "details": "30 kg • ₹18/kg • 5 days ago"},
    {"name": "Potatoes", "details": "40 kg • ₹22/kg • 1 week ago"},
    {"name": "Carrots", "details": "20 kg • ₹30/kg • 1 week ago"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2196F3),
        title: const Text(
          "Add Produce",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selection
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    isExpanded: true,
                    items: languages.map((lang) {
                      return DropdownMenuItem(
                        value: lang,
                        child: Text(
                          lang,
                          style: const TextStyle(color: Color(0xFF212121)),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedLanguage = value!;
                      });
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Voice Input Section
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      backgroundColor: const Color(0xFF4CAF50),
                      padding: const EdgeInsets.all(24),
                    ),
                    onPressed: () {
                      // TODO: Hook voice recognition logic here
                    },
                    child: const Icon(Icons.mic, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Tap to speak and describe your produce",
                    style: TextStyle(color: Color(0xFF616161)),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      title: const Text(
                        "உங்கள் பொருட்களின் விவரங்கள் இங்கே தோன்றும்...",
                        style: TextStyle(color: Color(0xFF616161)),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Color(0xFF2196F3)),
                        onPressed: () {
                          // TODO: Allow manual editing
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Produce History Section
            const Text(
              "Your Previous Produce",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF212121),
              ),
            ),
            const SizedBox(height: 12),

            produceHistory.isEmpty
                ? Column(
                    children: const [
                      Icon(Icons.history, size: 60, color: Colors.grey),
                      SizedBox(height: 8),
                      Text(
                        "No produce yet. Add your first using voice input.",
                        style: TextStyle(color: Color(0xFF616161)),
                      ),
                    ],
                  )
                : Column(
                    children: produceHistory.map((produce) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          title: Text(
                            produce["name"]!,
                            style: const TextStyle(color: Color(0xFF212121)),
                          ),
                          subtitle: Text(
                            produce["details"]!,
                            style: const TextStyle(color: Color(0xFF616161)),
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2196F3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Re-add produce
                            },
                            child: const Text(
                              "Add Again",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
            const SizedBox(height: 80), // Space for CTA button
          ],
        ),
      ),

      // Sticky CTA
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4CAF50),
            minimumSize: const Size(double.infinity, 50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            // TODO: Submit produce action
          },
          child: const Text(
            "Submit Produce",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
