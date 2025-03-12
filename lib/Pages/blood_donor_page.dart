import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonorListPage extends StatelessWidget {
  final List<Map<String, String>> donors;

  BloodDonorListPage({required this.donors});

  void _callDonor(String contact) async {
    final Uri url = Uri.parse("tel:$contact");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  void _whatsappDonor(String contact) async {
    final Uri url = Uri.parse("https://wa.me/$contact");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Blood Donors")),
      body: ListView.builder(
        itemCount: donors.length,
        itemBuilder: (context, index) {
          final donor = donors[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/images/user1.jpeg"), // Add an image to assets
                backgroundColor: Colors.red.shade200,
              ),
              title: Text(donor["name"] ?? "Unknown"),
              subtitle: Text("Blood Group: ${donor["blood_group"] ?? "N/A"}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.phone, color: Colors.red.shade700),
                    onPressed: () => _callDonor(donor["contact"] ?? ""),
                  ),
                  IconButton(
                    icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green), // WhatsApp icon
                    onPressed: () => _whatsappDonor(donor["contact"] ?? ""),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
