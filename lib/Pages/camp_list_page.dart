import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'camp_detail_page.dart';

class CampListPage extends StatefulWidget {
  @override
  _CampListPageState createState() => _CampListPageState();
}

class _CampListPageState extends State<CampListPage> {
  List<dynamic> camps = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchCamps();
  }

  Future<void> fetchCamps() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.76.200:46657/camps'));
      // final response = await http.get(Uri.parse('http://10.0.2.2:5000/camps'));// for emulator

      if (response.statusCode == 200) {
        setState(() {
          camps = json.decode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load camps. Server error ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        errorMessage = 'Network error: ${error.toString()}';
        isLoading = false;
      });
    }
  }

  void openGoogleMaps(String location) async {
    final encodedLocation = Uri.encodeComponent(location);
    final url = 'https://www.google.com/maps/search/?api=1&query=$encodedLocation';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/blood2.png'),
              radius: 18,
            ),
            SizedBox(width: 10),
            Text('Blood Donation', style: TextStyle(color: Colors.black)),
          ],
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0),
            child: Image.asset(
              'assets/images/blood3.jpeg',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(child: Text(errorMessage, style: TextStyle(color: Colors.white)))
                : ListView.builder(
              itemCount: camps.length,
              itemBuilder: (context, index) {
                final camp = camps[index];
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(
                      camp['name'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Location: ${camp['location']}'),
                        Text(
                          'Date: ${camp['date'] ?? "No date available"}',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.location_on, color: Colors.red),
                          onPressed: () => openGoogleMaps(camp['location']),
                        ),
                        Icon(Icons.arrow_forward_ios, color: Colors.black),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CampDetailPage(camp: camp),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}