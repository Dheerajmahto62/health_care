import 'package:flutter/material.dart';

class PatientHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Doses"),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Medicine Schedule",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildMedicineCard("Paracetamol", "8:00 AM", "Taken"),
                  _buildMedicineCard("Antibiotic", "2:00 PM", "Upcoming"),
                  _buildMedicineCard("Vitamin C", "8:00 PM", "Missed"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicineCard(String name, String time, String status) {
    Color statusColor;
    if (status == "Taken") {
      statusColor = Colors.green;
    } else if (status == "Missed") {
      statusColor = Colors.red;
    } else {
      statusColor = Colors.orange;
    }

    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text("Time: $time"),
        trailing: Text(
          status,
          style: TextStyle(fontWeight: FontWeight.bold, color: statusColor),
        ),
      ),
    );
  }
}
