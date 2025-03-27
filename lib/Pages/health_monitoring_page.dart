import 'package:flutter/material.dart';

class HealthMonitoringPage extends StatefulWidget {
  @override
  _HealthMonitoringPageState createState() => _HealthMonitoringPageState();
}

class _HealthMonitoringPageState extends State<HealthMonitoringPage> {
  final TextEditingController _bloodSugarController = TextEditingController();
  final TextEditingController _bpController = TextEditingController();
  final List<Map<String, String>> _healthData = [];

  void _addHealthData() {
    setState(() {
      _healthData.add({
        'Blood Sugar': _bloodSugarController.text,
        'BP': _bpController.text,
        'Date': DateTime.now().toString().split(' ')[0]
      });
      _bloodSugarController.clear();
      _bpController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Monitoring'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _bloodSugarController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Blood Sugar (mg/dL)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _bpController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Blood Pressure (e.g., 120/80)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addHealthData,
              child: Text('Save Data'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _healthData.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('Blood Sugar: ${_healthData[index]['Blood Sugar']} mg/dL'),
                      subtitle: Text('BP: ${_healthData[index]['BP']} | Date: ${_healthData[index]['Date']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
