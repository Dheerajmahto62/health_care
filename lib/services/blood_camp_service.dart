import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';

class BloodCampService {
  static const String googlePlacesApiKey = "YOUR_GOOGLE_API_KEY";

  // Function to get current location
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  // Function to fetch nearby blood camps
  static Future<List<Map<String, dynamic>>> fetchNearbyBloodCamps(
      double latitude, double longitude) async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
        "?location=$latitude,$longitude"
        "&radius=50000"
        "&keyword=blood donation camp"
        "&key=$googlePlacesApiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Map<String, dynamic>> camps = [];

      for (var result in data['results']) {
        camps.add({
          "name": result["name"],
          "address": result["vicinity"],
          "location": result["geometry"]["location"],
        });
      }
      return camps;
    } else {
      throw Exception("Failed to fetch blood camps");
    }
  }
}
