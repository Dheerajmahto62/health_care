import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class BloodDonorListPage extends StatelessWidget {
  final List<Map<String, String>> donors;

  BloodDonorListPage({required this.donors});

  // Function to call a donor
  Future<void> _callDonor(String contact) async {
    final Uri url = Uri(scheme: "tel", path: contact);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      print("Could not launch call: $url");
    }
  }

  // Function to open WhatsApp chat
  Future<void> _whatsappDonor(String contact) async {
    String phoneNumber = contact.replaceAll(" ", "").replaceAll("+", "");
    final Uri url = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      print("Could not launch WhatsApp: $url");
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
          String imagePath = donor["image"] ?? "assets/images/user1.jpeg"; // Default image if none provided

          return Card(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: imagePath.startsWith("http")
                    ? NetworkImage(imagePath) // For online images
                    : AssetImage(imagePath) as ImageProvider, // For local assets
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
                    icon: FaIcon(FontAwesomeIcons.whatsapp, color: Colors.green),
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
