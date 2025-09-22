import 'package:flutter/material.dart';

const Color themeColor = Color.fromARGB(255, 76, 175, 80);

class NewCoopScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text('New Co-op'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          Text('Create Your Co-op', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          Text('Co-op Name'),
          SizedBox(height: 4),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: 'Enter co-op name',
              border: OutlineInputBorder(),
              isDense: true,
            ),
          ),
          SizedBox(height: 12),
          Text('Short Description'),
          SizedBox(height: 4),
          TextField(
            controller: descController,
            decoration: InputDecoration(
              hintText: "Describe your co-op's mission and goals...",
              border: OutlineInputBorder(),
              isDense: true,
              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColor,
                padding: EdgeInsets.symmetric(vertical: 14),
              ),
              onPressed: () {},
              child: Text('Create Co-op'),
            ),
          ),
          SizedBox(height: 20),
          Text('Join Existing Co-ops', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 12),
          JoinCoopTile(title: 'Green Valley Co-op', description: 'Sustainable farming practices'),
          JoinCoopTile(title: 'Agri Co-op', description: 'Modern agricultural solutions'),
          JoinCoopTile(title: 'FreshHarvest Co-op', description: 'Farm to table excellence'),
          JoinCoopTile(title: 'Village Unity Co-op', description: 'Community-driven farming'),
          JoinCoopTile(title: 'EcoFarmers Co-op', description: 'Organic and eco-friendly methods'),
        ],
      ),
    );
  }
}

class JoinCoopTile extends StatelessWidget {
  final String title, description;
  JoinCoopTile({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: themeColor,
            padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          ),
          onPressed: () {},
          child: Text('Join'),
        ),
      ),
    );
  }
}
