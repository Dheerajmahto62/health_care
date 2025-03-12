import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medical Healthcare App',
      theme: ThemeData(primarySwatch: Colors.red),
      home: DashboardPage(),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard')),
      body: Center(
        child: serviceContainer(
          context,
          'Register History',
          Icons.history,
          RegisterHistoryPage(),
        ),
      ),
    );
  }

  Widget serviceContainer(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 200,
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 30, color: Colors.red),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class RegisterHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> registerHistory = [
    {
      "registrationId": "R001",
      "fullName": "Dheeraj",
      "userRole": "Donor",
      "registrationDate": "2024-02-10 14:00",
      "lastLogin": "2024-02-25 18:30",
      "accountStatus": "Active",
      "previousDonations": 5,
      "lastDonationDate": "2024-01-15",
      "campaignsAttended": 3,
      "verificationStatus": "Verified",
      "remarks": "Regular donor",
    },
    {
      "registrationId": "R002",
      "fullName": "Just D",
      "userRole": "Nurse",
      "registrationDate": "2023-12-05 09:15",
      "lastLogin": "2024-02-20 10:45",
      "accountStatus": "Active",
      "previousDonations": 0,
      "lastDonationDate": "N/A",
      "campaignsAttended": 5,
      "verificationStatus": "Verified",
      "remarks": "Excellent service record",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register History')),
      body: ListView.builder(
        itemCount: registerHistory.length,
        itemBuilder: (context, index) {
          final record = registerHistory[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterHistoryDetailsPage(record: record),
                ),
              );
            },
            child: Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(record["fullName"]),
                subtitle: Text('Role: ${record["userRole"]}\nStatus: ${record["accountStatus"]}'),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RegisterHistoryDetailsPage extends StatelessWidget {
  final Map<String, dynamic> record;

  RegisterHistoryDetailsPage({required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${record["fullName"]} Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('User Role: ${record["userRole"]}', style: TextStyle(fontSize: 18)),
            Text('Registration Date: ${record["registrationDate"]}'),
            Text('Last Login: ${record["lastLogin"]}'),
            Text('Account Status: ${record["accountStatus"]}'),
            Text('Previous Donations: ${record["previousDonations"]}'),
            Text('Last Donation Date: ${record["lastDonationDate"]}'),
            Text('Campaigns Attended: ${record["campaignsAttended"]}'),
            Text('Verification Status: ${record["verificationStatus"]}'),
            Text('Remarks: ${record["remarks"]}'),
          ],
        ),
      ),
    );
  }
}
