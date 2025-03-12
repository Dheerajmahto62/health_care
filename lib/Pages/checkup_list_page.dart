import 'package:flutter/material.dart';

class CheckupListPage extends StatefulWidget {
  @override
  _CheckupListPageState createState() => _CheckupListPageState();
}

class _CheckupListPageState extends State<CheckupListPage> {
  List<Map<String, dynamic>> checkupRecords = [
    {
      'checkupId': 'CHK123',
      'patientId': 'PAT001',
      'fullName': 'Rahul',
      'age': 30,
      'gender': 'Male',
      'checkupDateTime': '2025-02-26 10:00 AM',
      'doctorName': 'Dr. Smith',
      'doctorId': 'DOC101',
      'checkupType': 'General',
      'healthParams': 'BP: 120/80, Sugar: 90 mg/dL',
      'medicalConditions': 'None',
      'prescriptions': 'Vitamin D Supplements',
      'nextCheckupDate': '2025-03-15',
      'checkupStatus': 'Completed',
      'expanded': false,
    },
    {
      'checkupId': 'CHK124',
      'patientId': 'PAT002',
      'fullName': 'Neha',
      'age': 25,
      'gender': 'Female',
      'checkupDateTime': '2025-02-26 11:00 AM',
      'doctorName': 'Dr. Williams',
      'doctorId': 'DOC102',
      'checkupType': 'Diabetes',
      'healthParams': 'Sugar: 150 mg/dL',
      'medicalConditions': 'Prediabetes',
      'prescriptions': 'Metformin 500mg',
      'nextCheckupDate': '2025-03-20',
      'checkupStatus': 'Pending',
      'expanded': false,
    },
  ];

  void toggleExpand(int index) {
    setState(() {
      checkupRecords[index]['expanded'] = !checkupRecords[index]['expanded'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Checkup List')),
      body: ListView.builder(
        itemCount: checkupRecords.length,
        itemBuilder: (context, index) {
          var record = checkupRecords[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                ListTile(
                  title: Text(record['fullName'] ?? 'Unknown'),
                  subtitle: Text(record['checkupType'] ?? 'N/A'),
                  trailing: Icon(
                    record['expanded'] ? Icons.expand_less : Icons.expand_more,
                    color: Colors.red,
                  ),
                  onTap: () => toggleExpand(index),
                ),
                if (record['expanded'])
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        infoRow('Checkup ID:', record['checkupId']),
                        infoRow('Patient ID:', record['patientId']),
                        infoRow('Age:', record['age'].toString()),
                        infoRow('Gender:', record['gender']),
                        infoRow('Date & Time:', record['checkupDateTime']),
                        infoRow('Doctor:', '${record['doctorName']} (ID: ${record['doctorId']})'),
                        infoRow('Health Parameters:', record['healthParams']),
                        infoRow('Medical Conditions:', record['medicalConditions']),
                        infoRow('Prescriptions:', record['prescriptions']),
                        infoRow('Next Checkup Date:', record['nextCheckupDate']),
                        infoRow('Status:', record['checkupStatus']),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget infoRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 5),
          Expanded(child: Text(value ?? 'N/A')),
        ],
      ),
    );
  }
}
