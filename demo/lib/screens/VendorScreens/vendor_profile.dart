import 'package:flutter/material.dart';

const Color kBlueTheme = Color(0xFF2459B2);
const Color kGreenCard = Color(0xFF239F6C);
const Color kBlueCard = Color(0xFF3455D5);
const Color kVioletCard = Color(0xFF7A3FC2);
const Color kOrangeCard = Color(0xFFEE8031);

class MiddlemanProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      appBar: AppBar(
        title: Text(
          'Middleman Profile',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: kBlueTheme,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 14),
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: AssetImage(
                      'assets/CustomerUIAssets/images/Sarah.png',
                    ),
                  ),
                  SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Marcus Rodriguez',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Supply Chain\nCoordinator',
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 17),
                            SizedBox(width: 3),
                            Text(
                              '4.8',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              '156 reviews',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            SizedBox(width: 3),
                            Text(
                              'Texas, USA',
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Overview cards
              SizedBox(height: 20),
              Text(
                'Overview',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: _gridCard(
                      kGreenCard,
                      'Inventory Size',
                      '2,450',
                      'items',
                      Icons.inventory,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _gridCard(
                      kBlueCard,
                      'Procurement',
                      '\$1.2M',
                      'this month',
                      Icons.local_grocery_store,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _gridCard(
                      kVioletCard,
                      'Transactions',
                      '847',
                      'completed',
                      Icons.swap_horiz,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _gridCard(
                      kOrangeCard,
                      'Active Deals',
                      '23',
                      'ongoing',
                      Icons.assignment,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 18),
              // Performance section
              Text(
                'Performance',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 10),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Timely Deliveries',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          Text(
                            '94.2%',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: kGreenCard,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.942,
                        color: kGreenCard,
                        backgroundColor: Colors.grey[300],
                        minHeight: 7,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Partner Ratings',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Text(
                        '4.8/5.0',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: kBlueTheme,
                        ),
                      ),
                      SizedBox(width: 11),
                      Row(
                        children: List.generate(5, (i) {
                          return Icon(
                            Icons.star,
                            color: i < 4 ? Colors.amber : Colors.grey[400],
                            size: 16,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 18),
              // Recent Activity
              Text(
                'Recent Activity',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 7),
              _activityTile(
                Icons.note_add,
                'Procurement Record Updated',
                'Agricultural supplies - \$45,200',
                '2 hours ago',
                kGreenCard,
              ),
              _activityTile(
                Icons.sync,
                'Supply Chain Update',
                'Route optimization completed',
                '5 hours ago',
                kBlueTheme,
              ),
              _activityTile(
                Icons.verified,
                'Transaction Verified',
                'Organic produce delivery confirmed',
                '1 day ago',
                Colors.green,
              ),
              SizedBox(height: 18),
              // Documents Section
              Text(
                'Documents',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  _documentTile(
                    Icons.description,
                    'Licenses',
                    '5 docs',
                    kGreenCard,
                  ),
                  SizedBox(width: 10),
                  _documentTile(
                    Icons.verified,
                    'Certifications',
                    '8 docs',
                    kBlueTheme,
                  ),
                  SizedBox(width: 10),
                  _documentTile(
                    Icons.home_work,
                    'Permits',
                    '3 docs',
                    kOrangeCard,
                  ),
                ],
              ),
              SizedBox(height: 18),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.payment),
                      label: Text('Send Payment'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenCard,
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.view_list),
                      label: Text('View Deals'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kBlueTheme,
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(45),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 9),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Remove'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                        side: BorderSide(color: Colors.grey.shade300),
                        minimumSize: Size.fromHeight(45),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Block'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red[700],
                        backgroundColor: Colors.red[50],
                        side: BorderSide(color: Colors.red.shade100),
                        minimumSize: Size.fromHeight(45),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _gridCard(
    Color color,
    String title,
    String value,
    String desc,
    IconData icon,
  ) {
    return Card(
      color: color,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 27),
            SizedBox(height: 7),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2),
            Text(desc, style: TextStyle(color: Colors.white70, fontSize: 13)),
          ],
        ),
      ),
    );
  }

  Widget _activityTile(
    IconData icon,
    String title,
    String subtitle,
    String time,
    Color color,
  ) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 13),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentTile(IconData icon, String title, String desc, Color color) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Column(
            children: [
              Icon(icon, color: color, size: 29),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 13, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
