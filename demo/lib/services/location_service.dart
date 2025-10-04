import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService {
  static Future<LocationResult> getCurrentLocation() async {
    try {
      // Check and request permission
      var permission = await Permission.location.request();
      print("Permission status: $permission");
      if (permission.isDenied) {
        print("Permission denied");
        return LocationResult(
          success: false,
          error: 'Location permission denied',
        );
      }

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return LocationResult(
          success: false,
          error: 'Location services are disabled',
        );
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      // Generate location name (you can integrate geocoding here)
      String locationName =
          "Farm Location - Lat: ${position.latitude.toStringAsFixed(4)}, Lon: ${position.longitude.toStringAsFixed(4)}";

      return LocationResult(
        success: true,
        latitude: position.latitude,
        longitude: position.longitude,
        locationName: locationName,
      );
    } catch (e) {
      return LocationResult(
        success: false,
        error: 'Failed to get location: $e',
      );
    }
    
  }
}

class LocationResult {
  final bool success;
  final double? latitude;
  final double? longitude;
  final String? locationName;
  final String? error;

  LocationResult({
    required this.success,
    this.latitude,
    this.longitude,
    this.locationName,
    this.error,
  });
}
