import 'package:flutter/material.dart';

class CampingPeopleListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camping People'),
      ),
      body: ListView.builder(
        itemCount: campingPeople.length,
        itemBuilder: (context, index) {
          final person = campingPeople[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(person['fullName']),
              subtitle: Text("Blood Group: ${person['bloodGroup']} | Status: ${person['donationStatus']}"),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CampingPeopleDetailsPage(person: person),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class CampingPeopleDetailsPage extends StatelessWidget {
  final Map<String, dynamic> person;

  CampingPeopleDetailsPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(person['fullName']),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Campaign ID: ${person['campaignID']}", style: TextStyle(fontSize: 16)),
            Text("Donor ID: ${person['donorID']}", style: TextStyle(fontSize: 16)),
            Text("Age: ${person['age']}", style: TextStyle(fontSize: 16)),
            Text("Gender: ${person['gender']}", style: TextStyle(fontSize: 16)),
            Text("Blood Group: ${person['bloodGroup']}", style: TextStyle(fontSize: 16)),
            Text("Contact: ${person['contactNumber']}", style: TextStyle(fontSize: 16)),
            Text("Email: ${person['email']}", style: TextStyle(fontSize: 16)),
            Text("Address: ${person['address']}", style: TextStyle(fontSize: 16)),
            Text("Campaign Location: ${person['campaignLocation']}", style: TextStyle(fontSize: 16)),
            Text("Campaign Date: ${person['campaignDate']}", style: TextStyle(fontSize: 16)),
            Text("Health Screening Status: ${person['healthScreeningStatus']}", style: TextStyle(fontSize: 16)),
            Text("Donation Status: ${person['donationStatus']}", style: TextStyle(fontSize: 16)),
            Text("Hemoglobin Level: ${person['hemoglobinLevel']}", style: TextStyle(fontSize: 16)),
            Text("Remarks: ${person['remarks']}", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

// Sample Data
List<Map<String, dynamic>> campingPeople = [
  {
    'campaignID': 'CAMP001',
    'donorID': 'D001',
    'fullName': 'Dheeraj',
    'age': 29,
    'gender': 'Male',
    'bloodGroup': 'O+',
    'contactNumber': '9876543210',
    'email': 'dkmahto708@example.com',
    'address': 'New York, NY, 10001',
    'campaignLocation': 'NYC Blood Camp',
    'campaignDate': '2025-02-28',
    'healthScreeningStatus': 'Passed',
    'donationStatus': 'Completed',
    'hemoglobinLevel': '14.2 g/dL',
    'remarks': 'No issues',
  },
  {
    'campaignID': 'CAMP001',
    'donorID': 'D001',
    'fullName': 'Sahul',
    'age': 29,
    'gender': 'Male',
    'bloodGroup': 'O+',
    'contactNumber': '9876543210',
    'email': 'sahul@example.com',
    'address': 'New York, NY, 10001',
    'campaignLocation': 'NYC Blood Camp',
    'campaignDate': '2025-02-28',
    'healthScreeningStatus': 'Passed',
    'donationStatus': 'Completed',
    'hemoglobinLevel': '14.2 g/dL',
    'remarks': 'No issues',
  },
];
