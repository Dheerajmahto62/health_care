import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'blood_donor_page.dart';
import 'chat_bot_page.dart';
import 'checkup_list_page.dart';
import 'doctor_appointment_page.dart';
import 'document_verification_page.dart';
import 'login_page.dart';
import 'nearby_shops_page.dart';
import 'nurse_list_page.dart';
import 'patient_timeline_page.dart';
import 'health_monitoring_page.dart';

class DashboardPage extends StatefulWidget {
  final String token;
  DashboardPage({required this.token});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int rewardCoins = 0;
  List<Map<String, dynamic>> bloodDonors = [];

  Future<void> fetchDonors() async {
    const String apiUrl = 'https://medical-python.vercel.app/donors';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> donors = jsonDecode(response.body);
        setState(() {
          bloodDonors =
              donors.map((donor) => donor as Map<String, dynamic>).toList();
        });
      } else {
        print('Failed to fetch donors. Status Code: \${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching donors: \$e");
    }
  }
  void _donateBlood() {
    setState(() {
      rewardCoins += 10; // Add 10 coins per donation
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Thank you for donating! You've earned 10 coins."),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchDonors();
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Life Save'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Row(
              children: [
                Icon(Icons.monetization_on, color: Colors.red ),
                SizedBox(width: 5),
                Text('$rewardCoins', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ],


      ),
      drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatBotPage()),
          );
        },
        child: Icon(Icons.chat, color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Text(
              "Service",
              style: TextStyle(
                fontSize: 20, // Increased font size
                fontWeight: FontWeight.bold,
                color: Colors.red, // Set text color to red
              ),
            ),

            Expanded(
              child: GridView.count(
                crossAxisCount: 3, // 3 columns
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,

                children: [
                  _buildServiceContainer(
                    context,
                    'Blood Donor',
                    Icons.bloodtype,
                    () {
                      if (bloodDonors.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => BloodDonorListPage(
                                  donors:
                                      bloodDonors
                                          .map(
                                            (donor) => donor.map(
                                              (key, value) => MapEntry(
                                                key,
                                                value.toString(),
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "No blood donors available. Please try again later.",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  _buildServiceContainer(
                    context,
                    'Checkup',
                    Icons.local_hospital,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckupListPage(),
                      ),
                    ),
                  ),

                  _buildServiceContainer(
                    context,
                    'Doctor Appointment',
                    Icons.local_hospital_outlined,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorAppointmentPage(),
                      ),
                    ),
                  ),
                  _buildServiceContainer(
                    context,
                    'Nurse Center',
                    Icons.medical_services,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NurseListPage()),
                    ),
                  ),
                  _buildServiceContainer(
                    context,
                    'Medical Shops',
                    Icons.store,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NearbyShopsPage(),
                      ),
                    ),
                  ),
                  _buildServiceContainer(
                    context,
                    'Documentation',
                    Icons.assignment,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DocumentVerificationPage(),
                      ),
                    ),
                  ),
                  _buildServiceContainer(
                    context,
                    'Patient Timeline',
                    Icons.timeline,
                    () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientHistoryPage(),
                      ),
                    ),
                  ),
              _buildServiceContainer(
                context,
                'Health Monitoring',
                Icons.monitor_heart,
                    () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HealthMonitoringPage(),
                  ),
                ),
              )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Dheeraj Mahto"),
            accountEmail: Text("dkmahto708@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 50, color: Colors.red),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {}),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
          _buildDrawerItem(Icons.person, 'Profile', () {}),
          _buildDrawerItem(Icons.logout, 'Logout', _logout),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red.shade900),
      title: Text(title, style: TextStyle(color: Colors.black)),
      onTap: onTap,
    );
  }

  Widget _buildHeaderImage() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/nurse.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildServiceContainer(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(500),
          boxShadow: [
            BoxShadow(color: Colors.white, blurRadius: 5, spreadRadius: 2),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.red),
            SizedBox(height: 5),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
