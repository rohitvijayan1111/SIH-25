import 'package:flutter/material.dart';
import 'package:demo/models/certificate_model.dart';
import '../services/certificate_service.dart';

class CertificateDetailsScreen extends StatefulWidget {
  final String batchId;
  final String certId;

  const CertificateDetailsScreen({
    Key? key,
    required this.batchId,
    required this.certId,
  }) : super(key: key);

  @override
  State<CertificateDetailsScreen> createState() =>
      _CertificateDetailsScreenState();
}

class _CertificateDetailsScreenState extends State<CertificateDetailsScreen> {
  Certificate? certificate;
  bool isLoading = true;
  bool isVerified = false;

  final Color  themeColor = const Color.fromARGB(255, 12, 131, 69);

  @override
  void initState() {
    super.initState();
    loadCertificate();
  }

  Future<void> loadCertificate() async {
    final cert = await CertificateService.fetchCertificate(
      widget.batchId,
      widget.certId,
    );
    setState(() {
      certificate = cert;
      isLoading = false;
    });
  }

  Future<void> verifyCertificate() async {
    final result = await CertificateService.verifyCertificate(
      widget.batchId,
      widget.certId,
    );
    setState(() {
      isVerified = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: themeColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Certificate Details",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).maybePop(),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : certificate == null
          ? const Center(child: Text("No data found"))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundColor: Color(0xFFE7F7ED),
                            radius: 31,
                            child: Icon(
                              Icons.verified,
                              color: themeColor,
                              size: 38,
                            ),
                          ),
                        ),
                        const SizedBox(height: 13),
                        _buildDetail("Batch ID", certificate!.batchId),
                        _buildDetail("Certificate ID", certificate!.certId),
                        _buildDetail("Certificate Hash", certificate!.certHash),
                        _buildDetail("Issuer ID", certificate!.issuerId),
                        _buildDetail("Issuer Name", certificate!.issuerName),
                        _buildDetail("Issued At", certificate!.issuedAt),
                        _buildDetail("File CID", certificate!.fileCid),
                        _buildDetail(
                          "Blockchain Transaction Hash",
                          certificate!.chainTx,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  if (isVerified)
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 8,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.verified, color: themeColor, size: 21),
                            const SizedBox(width: 8),
                            Text(
                              "Verified Certificate",
                              style: TextStyle(
                                color: themeColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (isVerified) const SizedBox(height: 13),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton.icon(
                      onPressed: verifyCertificate,
                      icon: const Icon(Icons.verified),
                      label: const Text(
                        "Verify Certificate",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.download_rounded,
                        color: Colors.black87,
                      ),
                      label: const Text("Download Certificate"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(
                          color: Color(0xFFDADADA),
                          width: 1.3,
                        ),
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.share, color: Colors.black87),
                      label: const Text("Share Certificate"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black87,
                        side: const BorderSide(
                          color: Color(0xFFDADADA),
                          width: 1.3,
                        ),
                        backgroundColor: Colors.white,
                        textStyle: const TextStyle(fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(height: 2.5),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 5),
          const Divider(height: 0, color: Color(0xFFE5E5E5), thickness: 1),
        ],
      ),
    );
  }
}
