import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'login_page.dart';
import 'register_page.dart';

class CampDetailPage extends StatelessWidget {
  final Map<String, dynamic> camp;

  CampDetailPage({required this.camp});

  // // Function to open Google Maps for the camp location
  // void _openMap(BuildContext context) async {
  //   double? latitude = camp['latitude'];
  //   double? longitude = camp['longitude'];
  //
  //   if (latitude != null && longitude != null) {
  //     String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
  //
  //     Uri uri = Uri.parse(googleMapsUrl);
  //     if (await canLaunchUrl(uri)) {
  //       await launchUrl(uri, mode: LaunchMode.externalApplication);
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(content: Text("Could not open the map."))
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text("Location details are missing."))
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(camp['name'] ?? "No Name Available"),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Camp Name
            Text('Camp Name:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(camp['name'] ?? 'Unknown', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            // Location
            Text('Location:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(camp['location'] ?? 'Unknown', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            // Date
            Text('Date:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(camp['date'] ?? 'No date available', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            // Available Spots
            Text('Available Spots:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text('${camp['available_spots'] ?? 'Unknown'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            // Details
            Text('Details:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(camp['details'] ?? 'No details available', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),

            // // Open in Google Maps
            // Center(
            //   child: ElevatedButton.icon(
            //     icon: Icon(Icons.map),
            //     label: Text("View on Map"),
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Colors.blue,
            //       foregroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //     ),
            //     onPressed: () => _openMap(context),
            //   ),
            // ),

            Spacer(),

            // Register & Login Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text("Register"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
