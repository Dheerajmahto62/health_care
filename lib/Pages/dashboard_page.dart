import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'nurse_list_page.dart';
import 'blood_donor_page.dart';
import 'camping_people_list.dart';
import 'document_verification_page.dart';
import 'register_history_page.dart';
import 'checkup_list_page.dart';
import 'login_page.dart';
import 'chat_bot_page.dart';

class DashboardPage extends StatefulWidget {
  final String token;
  DashboardPage({required this.token});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Map<String, dynamic>> bloodDonors = [];

  Future<void> fetchDonors() async {
    const String apiUrl = 'http://192.168.120.200:39723/donors';
    // const String apiUrl = 'http://10.0.2.2:5000/donors';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> donors = jsonDecode(response.body);
        setState(() {
          bloodDonors = donors.map((donor) => donor as Map<String, dynamic>).toList();
        });
        print("Fetched Donors: \$bloodDonors"); // Debugging log
      } else {
        print('Failed to fetch donors. Status Code: \${response.statusCode}');
      }
    } catch (e) {
      print("Error fetching donors: \$e");
    }
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
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ChatBotPage()));
        },
        child: Icon(Icons.chat, color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            _buildSectionTitle("Services", Colors.red),
            _buildHorizontalScrollView([
              _buildServiceContainer(
                context,
                'Blood Donor',
                Icons.bloodtype,
                    () {
                  if (bloodDonors.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BloodDonorListPage(
                          donors: bloodDonors.map((donor) => donor.map((key, value) => MapEntry(key, value.toString()))).toList(),
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("No blood donors available. Please try again later.")),
                    );
                  }
                },
              ),

              _buildServiceContainer(context, 'Checkup', Icons.local_hospital,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => CheckupListPage()))),
              _buildServiceContainer(context, 'Nurse Center', Icons.medical_services,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => NurseListPage()))),
            ]),
            _buildSectionTitle("Details", Colors.red),
            _buildHorizontalScrollView([
              _buildServiceContainer(context, 'Camping People', Icons.group,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => CampingPeopleListPage()))),
              _buildServiceContainer(context, 'Documentation', Icons.assignment,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => DocumentVerificationPage()))),
              _buildServiceContainer(context, 'Register History', Icons.history,
                      () => Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterHistoryPage()))),
            ]),
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

  Widget _buildSectionTitle(String title, Color color) {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(title,
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: color)),
    );
  }

  Widget _buildHorizontalScrollView(List<Widget> children) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: children,
      ),
    );
  }

  Widget _buildServiceContainer(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 100,
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.red),
            SizedBox(height: 5),
            Text(title,
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade900)),
          ],
        ),
      ),
    );
  }
}