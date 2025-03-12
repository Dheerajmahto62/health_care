import 'package:flutter/material.dart';

class DocumentationVerificationListPage extends StatelessWidget {
  final List<Map<String, String>> verificationList = [
    {
      'Verification ID': 'VER12345',
      'User ID': 'USR001',
      'Full Name': 'John Doe',
      'User Type': 'Donor',
      'Identity Proof': 'Aadhar',
      'Document Number': '1234-5678-9012',
      'Document Link': 'https://example.com/doc1.pdf',
      'Submission Date': '2025-02-26',
      'Status': 'Approved',
      'Verified By': 'Admin1 (ADM001)',
      'Rejection Reason': '',
      'Remarks': 'All details verified.',
    },
    {
      'Verification ID': 'VER67890',
      'User ID': 'USR002',
      'Full Name': 'Jane Smith',
      'User Type': 'Nurse',
      'Identity Proof': 'Passport',
      'Document Number': 'P12345678',
      'Document Link': 'https://example.com/doc2.pdf',
      'Submission Date': '2025-02-25',
      'Status': 'Rejected',
      'Verified By': 'Admin2 (ADM002)',
      'Rejection Reason': 'Invalid document',
      'Remarks': 'Please upload a valid passport.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Documentation Verification')),
      body: ListView.builder(
        itemCount: verificationList.length,
        itemBuilder: (context, index) {
          var verification = verificationList[index];
          return Card(
            margin: EdgeInsets.all(10),
            child: ListTile(
              title: Text(verification['Full Name'] ?? ''),
              subtitle: Text('Status: ${verification['Status']}'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationDetailsPage(verification: verification),
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

class VerificationDetailsPage extends StatelessWidget {
  final Map<String, String> verification;

  VerificationDetailsPage({required this.verification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Verification Details')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: verification.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text('${entry.key}: ${entry.value}', style: TextStyle(fontSize: 16)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
