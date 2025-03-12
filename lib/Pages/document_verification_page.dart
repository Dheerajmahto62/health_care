import 'package:flutter/material.dart';

class DocumentVerificationPage extends StatelessWidget {
  final List<Map<String, String>> documents = [
    {"name": "Dheeraj", "status": "Verified"},
    {"name": "Krishna", "status": "Pending"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Document Verification")),
      body: ListView.builder(
        itemCount: documents.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.verified, color: documents[index]["status"] == "Verified" ? Colors.green : Colors.orange),
            title: Text(documents[index]["name"]!),
            subtitle: Text("Status: ${documents[index]["status"]}"),
          );
        },
      ),
    );
  }
}
