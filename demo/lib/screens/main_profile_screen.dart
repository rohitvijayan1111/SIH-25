import 'package:flutter/material.dart';

const Color kGreenTheme = Color.fromARGB(255, 76, 175, 80);

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Picture and Member Status
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 44,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: kGreenTheme,
                    child: Icon(Icons.check, size: 18, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text('Raja lakshmi',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )),
              Text('+1 (555) 123-4567',
                  style: TextStyle(
                    color: Colors.grey[700],
                  )),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                decoration: BoxDecoration(
                  color: kGreenTheme.withAlpha(40),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text('Member',
                    style: TextStyle(
                      color: kGreenTheme,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.call),
                    label: Text('Call'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreenTheme,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.sms),
                    label: Text('SMS'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      foregroundColor: Colors.black,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {},
                    label: Text('WhatsApp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreenTheme,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22),
              // Overview section
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _overviewItem(
                          icon: Icons.trending_up,
                          color: kGreenTheme,
                          value: '127',
                          label: 'Contributions'),
                      _overviewItem(
                          icon: Icons.inbox,
                          color: Colors.blue[400]!,
                          value: '43',
                          label: 'Active Items'),
                      _overviewItem(
                          icon: Icons.attach_money,
                          color: Colors.amber[800]!,
                          value: '\$2,847',
                          label: 'Earnings'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 22),
              // Performance Section
              _performanceSection(),
              SizedBox(height: 22),
              // Recent Activity section
              _recentActivitySection(),
              SizedBox(height: 22),
              // Documents section
              _documentsSection(),
              SizedBox(height: 20),
              // Send Payment button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.send),
                  label: Text('Send Payment'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kGreenTheme,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // View History
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('View History'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: BorderSide(color: Colors.grey[300]!),
                    minimumSize: Size(double.infinity, 48),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Remove and Block
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Remove'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.orange[900],
                        side: BorderSide(color: Colors.orange[100]!),
                        backgroundColor: Colors.orange[50],
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Block'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[900],
                        side: BorderSide(color: Colors.red[100]!),
                        backgroundColor: Colors.red[50],
                        minimumSize: Size(double.infinity, 48),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _overviewItem(
      {required IconData icon,
      required Color color,
      required String value,
      required String label}) {
    return Column(
      children: [
        Icon(icon, color: color, size: 30),
        SizedBox(height: 8),
        Text(value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            )),
        Text(label,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            )),
      ],
    );
  }

  Widget _performanceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Performance', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Row(children: [
          Text('Success Rate'),
          Expanded(child: LinearProgressIndicator(
            value: 0.98,
            color: kGreenTheme,
            backgroundColor: Colors.grey[300],
          )),
          SizedBox(width: 10),
          Text('98%'),
        ]),
        SizedBox(height: 7),
        Row(children: [
          Text('Response Time'),
          Expanded(child: LinearProgressIndicator(
            value: 0.65,
            color: kGreenTheme,
            backgroundColor: Colors.grey[300],
          )),
          SizedBox(width: 10),
          Text('2.3h'),
        ]),
        SizedBox(height: 7),
        Row(children: [
          Text('Quality Score'),
          Expanded(child: LinearProgressIndicator(
            value: 0.98,
            color: kGreenTheme,
            backgroundColor: Colors.grey[300],
          )),
          SizedBox(width: 10),
          Text('4.9'),
        ]),
      ],
    );
  }

  Widget _recentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Recent Activity',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        ListTile(
          leading: Icon(Icons.check_circle, color: kGreenTheme),
          title: Text('Completed project delivery'),
          subtitle: Text('2 hours ago'),
        ),
        ListTile(
          leading: Icon(Icons.message, color: Colors.blue[400]),
          title: Text('Sent message to client'),
          subtitle: Text('5 hours ago'),
        ),
        ListTile(
          leading: Icon(Icons.star, color: Colors.amber[700]),
          title: Text('Received 5-star rating'),
          subtitle: Text('1 day ago'),
        ),
      ],
    );
  }

  Widget _documentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Documents',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 10),
        Card(
          child: ListTile(
            leading: Icon(Icons.picture_as_pdf, color: Colors.red),
            title: Text('Contract Agreement'),
            subtitle: Text('245 KB'),
            trailing: Icon(Icons.download, color: kGreenTheme),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.description, color: Colors.blue),
            title: Text('Project Brief'),
            subtitle: Text('156 KB'),
            trailing: Icon(Icons.download, color: kGreenTheme),
          ),
        ),
      ],
    );
  }
}
