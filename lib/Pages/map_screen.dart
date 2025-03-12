import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/blood_camp_service.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _loadMapData();
  }

  // Load current location and fetch nearby blood camps
  Future<void> _loadMapData() async {
    try {
      Position position = await BloodCampService.getCurrentLocation();
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });

      List<Map<String, dynamic>> camps = await BloodCampService.fetchNearbyBloodCamps(
        position.latitude,
        position.longitude,
      );

      Set<Marker> campMarkers = camps.map((camp) {
        return Marker(
          markerId: MarkerId(camp['name']),
          position: LatLng(
            camp['location']['lat'],
            camp['location']['lng'],
          ),
          infoWindow: InfoWindow(
            title: camp['name'],
            snippet: camp['address'],
          ),
        );
      }).toSet();

      setState(() {
        _markers = campMarkers;
      });
    } catch (error) {
      print("Error loading map data: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blood Camps Map"),
        backgroundColor: Colors.red,
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _currentLocation!,
          zoom: 12,
        ),
        markers: _markers,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
