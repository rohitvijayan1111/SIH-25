import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'certificates_details.dart';
import 'dart:convert';

// Your theme green:
const kGreen = Color.fromARGB(255, 12, 131, 69);

class ViewCertificates extends StatefulWidget {
  final String batchId;
  const ViewCertificates({required this.batchId, super.key});

  @override
  State<ViewCertificates> createState() => _ViewCertificatesState();
}

class _ViewCertificatesState extends State<ViewCertificates> {
  late Future<List<Certificate>> certificateFuture;

  @override
  void initState() {
    super.initState();
    certificateFuture = fetchCertificates();
  }

  Future<List<Certificate>> fetchCertificates() async {
    final url = Uri.parse(
      'http://localhost:3000/api/certificate/${widget.batchId}',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // Adjust this according to actual JSON structure:
      final decoded = json.decode(response.body);
      final List<dynamic> certs =
          decoded['certificates'] ?? []; // <-- adjust key if needed
      return certs.map((e) => Certificate.fromJson(e)).toList();
    }
    throw Exception('Failed to load certificates');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kGreen,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Certificates',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Batch #${widget.batchId.substring(0, 8)}',
              style: TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
        leading: BackButton(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<List<Certificate>>(
        future: certificateFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(child: CircularProgressIndicator(color: kGreen));
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final certs = snapshot.data ?? [];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 14, 12, 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey),
                            SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Search certificates...",
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                                style: TextStyle(fontSize: 15),
                                onChanged: (val) {
                                  // implement search/filter if needed
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Text(
                      'Total Certificates',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${certs.length}",
                      style: TextStyle(
                        color: kGreen,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: certs.isEmpty
                    ? Center(child: Text('No certificates found'))
                    : ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        itemCount: certs.length,
                        separatorBuilder: (_, __) => SizedBox(height: 10),
                        itemBuilder: (c, i) => CertificateCard(cert: certs[i]),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  height: 46,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kGreen,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // Implement export logic here
                      
                    },
                    icon: Icon(Icons.download),
                    label: Text('Export All Certificates'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class Certificate {
  final String number;
  final String issuer;

  Certificate({required this.number, required this.issuer});

  factory Certificate.fromJson(Map<String, dynamic> json) => Certificate(
    number: json['number'] ?? json['cert_id'] ?? '',
    issuer: json['issuer'] ?? json['issuer_name'] ?? '',
  );
}

class CertificateCard extends StatelessWidget {
  final Certificate cert;
  const CertificateCard({required this.cert});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        leading: Icon(Icons.circle, color: kGreen, size: 12),
        title: Text(
          cert.number,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(cert.issuer, style: TextStyle(fontSize: 13)),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 17,
          color: Colors.grey[600],
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CertificateDetailsScreen(
                batchId: 'af7df286-383c-44d1-8132-5f523c3e1cbe',
                certId: 'FSSAI-5678',
              ),
            ),
          );
        },
      ),
    );
  }
}
