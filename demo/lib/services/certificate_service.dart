import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/certificate_model.dart';

class CertificateService {
  static final String baseUrl = dotenv.env['API_BASE_URL'] ?? "";

  static Future<Certificate?> fetchCertificate(
    String batchId,
    String certId,
  ) async {
    final url = Uri.parse(
      "http://localhost:3000/api/certificate/$batchId/$certId",
    );
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Certificate.fromJson(data);
      } else {
        print("Error fetching certificate: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("Exception: $e");
      return null;
    }
  }

  static Future<bool> verifyCertificate(String batchId, String certId) async {
    final url = Uri.parse(
      "http://localhost:3000/api/certificate/$batchId/$certId/verify",
    );
    try {
      final response = await http.get(url);
      return response.statusCode == 200;
    } catch (e) {
      print("Verification failed: $e");
      return false;
    }
  }
}
