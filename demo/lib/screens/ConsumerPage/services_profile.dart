import 'package:flutter/material.dart';

const Color kGreenTheme = Color(0xFF4CAF50);
const Color kLightBlueCard = Color(0xFFE8EFF8);
const Color kSoftGreenCard = Color(0xFFEAF6EF);
const Color kYellowCard = Color(0xFFFFF6E1);

class FarmerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FB),
      appBar: AppBar(
        title: Text('Farmer Profile',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        backgroundColor: kGreenTheme,
        elevation: 0,
        actions: [
          IconButton(icon: Icon(Icons.more_vert,color: Colors.white,), onPressed: () {}),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {},
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with Avatar
            Container(
              color: kGreenTheme,
              child: Padding(
                padding: EdgeInsets.fromLTRB(18, 14, 18, 22),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      backgroundImage: AssetImage('assets/CustomerUIAssets/images/Sunita.png'),
                    ),
                    SizedBox(width: 18),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('John Anderson',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: Colors.white70, size: 17),
                            Text('Iowa, USA', style: TextStyle(color: Colors.white, fontSize: 15)),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text('Member since 2019', style: TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 6),
            // Purchase Overview Card
            Card(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Purchase Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 11),
                    Row(
                      children: [
                        Expanded(child: _purchaseTile(Icons.spa_outlined, 'Seeds', '\$2,450', kSoftGreenCard)),
                        SizedBox(width: 8),
                        Expanded(child: _purchaseTile(Icons.science, 'Fertilizers', '\$1,890', kLightBlueCard)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(child: _purchaseTile(Icons.warning_amber_rounded, 'Pesticides', '\$1,230', Color(0xFFFFF3EC))),
                        SizedBox(width: 8),
                        Expanded(child: _purchaseTile(Icons.build, 'Equipment', '\$3,670', Color(0xFFEFE8F9))),
                      ],
                    ),
                    SizedBox(height: 11),
                    Row(
                      children: [
                        Expanded(child: Text('Total Expenses', style: TextStyle(color: Colors.grey[700]))),
                        Text('\$9,240',
                          style: TextStyle(
                            color: kGreenTheme,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ))
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Service Subscriptions
            Card(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Service Subscriptions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 12),
                    _subscriptionTile(Icons.agriculture, 'Farm Loan', 'Active - \$25,000', 'Active', kSoftGreenCard, kGreenTheme),
                    SizedBox(height: 7),
                    _subscriptionTile(Icons.security, 'Crop Insurance', 'Premium - \$450/month', 'Active', kLightBlueCard, Colors.blue[700]!),
                    SizedBox(height: 7),
                    _subscriptionTile(Icons.school, 'Training Program', 'Organic Farming', 'In Progress', kYellowCard, Colors.orange[800]!),
                  ],
                ),
              ),
            ),
            // Recent Activity
            Card(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Recent Activity', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    _activityRow(Icons.shopping_cart, 'Purchased Organic Seeds'),
                    SizedBox(height: 8),
                    _activityRow(Icons.support, 'Support Ticket Resolved'),
                    SizedBox(height: 8),
                    _activityRow(Icons.check_circle, 'Training Module Completed', color: Colors.deepPurple),
                  ],
                ),
              ),
            ),
            // Documents Section
            Card(
              margin: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Documents', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(height: 10),
                    _documentTile(Icons.verified_user, 'Organic Certification'),
                    Divider(),
                    _documentTile(Icons.description, 'Farm Permit'),
                    Divider(),
                    _documentTile(Icons.card_membership, 'License'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            // Bottom Buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.shopping_bag_outlined),
                      label: Text('Buy Services'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kGreenTheme,
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.subscriptions),
                          label: Text('View Subscriptions'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[700],
                            foregroundColor: Colors.white,
                            minimumSize: Size.fromHeight(46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.person_remove),
                          label: Text('Remove'),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[800],
                            foregroundColor: Colors.white,
                            minimumSize: Size.fromHeight(46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Icon(Icons.block),
                      label: Text('Block User'),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red[700],
                        foregroundColor: Colors.white,
                        minimumSize: Size.fromHeight(46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }

  Widget _purchaseTile(IconData icon, String label, String value, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.grey[700], size: 22),
          Text(label, style: TextStyle(color: Colors.grey[800], fontSize: 13)),
          SizedBox(height: 3),
          Text(value, style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )),
        ],
      ),
    );
  }

  Widget _subscriptionTile(IconData icon, String label, String subtitle, String status, Color color, Color statusColor) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(13),
      ),
      padding: EdgeInsets.symmetric(vertical: 13, horizontal: 15),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.grey[700]),
          SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: TextStyle(color: Colors.grey[700], fontSize: 13)),
              ],
            ),
          ),
          SizedBox(width: 7),
          Text(status,
            style: TextStyle(fontWeight: FontWeight.bold, color: statusColor, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _activityRow(IconData icon, String label, {Color color = Colors.green}) {
    return Row(
      children: [
        Icon(icon, color: color, size: 22),
        SizedBox(width: 9),
        Text(label, style: TextStyle(color: Colors.grey[800], fontSize: 14)),
      ],
    );
  }

  Widget _documentTile(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: kGreenTheme, size: 20),
        SizedBox(width: 12),
        Expanded(
          child: Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ),
        Icon(Icons.download, color: Colors.grey[500], size: 22),
      ],
    );
  }
}
