import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../global.dart';
import 'splashscreen.dart';

class CollectDetails extends StatefulWidget {
  final String uid;
  final String name;
  final String email;
  final String authMethod;

  CollectDetails({
    required this.uid,
    required this.name,
    required this.email,
    required this.authMethod,
  });

  @override
  _CollectDetailsState createState() => _CollectDetailsState();
}

class _CollectDetailsState extends State<CollectDetails> {
  String _selectedState = "Select State";
  String _selectedDistrict = "Select District";
  String _selectedRole = "Select Role";

  List<String> roles = ["Select Role", "Admin", "User", "CSC"];

  List<String> states = [
    "Select State",
    "Tamil Nadu",
    "Kerala",
    "Karnataka",
    "Maharashtra",
  ];

  List<String> districts = [
    "Select District",
    "Chennai",
    "Coimbatore",
    "Madurai",
    "Salem",
  ];

  Future<void> _saveDetails() async {
    if (_selectedState == "Select State" ||
        _selectedDistrict == "Select District") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select both State and District")),
      );
      return;
    }

    await FirebaseFirestore.instance.collection("User").doc(widget.uid).set({
      "name": widget.name,
      "email": widget.email,
      "authMethod": widget.authMethod,
      "state": _selectedState,
      "district": _selectedDistrict,
      "role": _selectedRole,
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Profile")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<String>(
              value: _selectedState,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "State",
              ),
              onChanged: (val) => setState(() => _selectedState = val!),
              items: states
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedDistrict,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "District",
              ),
              onChanged: (val) => setState(() => _selectedDistrict = val!),
              items: districts
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _selectedRole,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Role",
              ),
              onChanged: (val) => setState(() => _selectedRole = val!),
              items: roles
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _saveDetails,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                "Save & Continue",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
