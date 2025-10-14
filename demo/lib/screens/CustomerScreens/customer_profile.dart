import 'package:flutter/material.dart';

const Color kOrangeTheme = Color(0xFFFFA726); // Orange
const Color kLightGreyBg = Color(0xFFF8F8F9);

class CustomerProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kLightGreyBg,
      appBar: AppBar(
        title: Text('Customer Profile',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        centerTitle: true,
        backgroundColor: kOrangeTheme,
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile header
            Container(
              decoration: BoxDecoration(
                color: kOrangeTheme,
              ),
              padding: EdgeInsets.fromLTRB(18, 12, 18, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 32,
                            backgroundImage: AssetImage('assets/CustomerUIAssets/images/David.png'),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.greenAccent,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.check, color: Colors.white, size: 16),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Sarah Johnson',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          SizedBox(height: 2),
                          Text('New York, NY',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              )),
                          SizedBox(height: 6),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 9),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.28),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text('Premium Member',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _headerButton('Call', Icons.call),
                      _headerButton('Message', Icons.message),
                      _headerButton('Email', Icons.email),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            // Info Cards Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      icon: Icons.shopping_bag_outlined,
                      label: 'Products Purchased',
                      value: '47',
                      iconColor: kOrangeTheme,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.attach_money,
                      label: 'Total Spending',
                      value: '\$2,847',
                      iconColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                    child: _infoCard(
                      icon: Icons.timelapse,
                      label: 'Monthly Frequency',
                      value: '2.4x',
                      iconColor: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _infoCard(
                      icon: Icons.star,
                      label: 'Feedback Rating',
                      value: '4.8',
                      iconColor: Colors.amber.shade700,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text('Recent Activity',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  _activityCard('MacBook Pro 14"', 'Ordered 2 days ago', '\$1,999', true),
                  _activityCard('AirPods Pro', 'Ordered 5 days ago', '\$249', false),
                ],
              ),
            ),
            SizedBox(height: 18),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Text('Documents',
                  style: TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18)),
            ),
            SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                children: [
                  _documentCard('Driver\'s License', Icons.folder, Colors.blue, true),
                  SizedBox(height: 7),
                  _documentCard('Address Proof', Icons.folder_special, Colors.green, true),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.favorite),
                  label: Text('Add to Wishlist'),
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kOrangeTheme,
                    foregroundColor: Colors.white,
                    minimumSize: Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('View Orders'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: BorderSide(color: Colors.grey.shade400),
                        minimumSize: Size.fromHeight(48),
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
                        minimumSize: Size.fromHeight(48),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _headerButton(String label, IconData icon) {
    return ElevatedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.25),
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(96, 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
      onPressed: () {},
    );
  }

  Widget _infoCard({required IconData icon, required String label, required String value, required Color iconColor}) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(8),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            SizedBox(height: 8),
            Text(value, style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            )),
            SizedBox(height: 4),
            Text(label, style: TextStyle(
              color: Colors.grey[700],
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _activityCard(String item, String time, String price, bool delivered) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              item.contains('MacBook') ? Icons.laptop_mac : Icons.headphones,
              color: Colors.grey[800],
              size: 32,
            ),
            SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item, style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16),
                  ),
                  SizedBox(height: 2),
                  Text(time, style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[600]),
                  ),
                  SizedBox(height: 6),
                  Text(price, style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: delivered ? Colors.green[50] : Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                delivered ? 'Delivered' : 'Shipping',
                style: TextStyle(
                  color: delivered ? Colors.green : Colors.orange,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _documentCard(String title, IconData icon, Color iconColor, bool verified) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 28),
        title: Text(title,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        trailing: verified
            ? Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Text('Verified',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
              )
            : null,
      ),
    );
  }
}
