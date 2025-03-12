import 'package:flutter/material.dart';

class Nurse {
  final String id;
  final String fullName;
  final String gender;
  final int age;
  final String contactNumber;
  final String email;
  final String address;
  final String qualification;
  final int experience;
  final String availability;
  final String assignedLocation;
  final List<String> services;
  final double rating;

  Nurse({
    required this.id,
    required this.fullName,
    required this.gender,
    required this.age,
    required this.contactNumber,
    required this.email,
    required this.address,
    required this.qualification,
    required this.experience,
    required this.availability,
    required this.assignedLocation,
    required this.services,
    required this.rating,
  });
}

class NurseListPage extends StatelessWidget {
  final List<Nurse> nurses = [
    Nurse(
      id: "N001",
      fullName: "Alice",
      gender: "Female",
      age: 32,
      contactNumber: "9876543210",
      email: "alice@example.com",
      address: "123 Main St, City",
      qualification: "BSc Nursing",
      experience: 8,
      availability: "9 AM - 5 PM",
      assignedLocation: "City Hospital",
      services: ["Blood Sample Collection", "Patient Care", "IV Injection"],
      rating: 4.5,
    ),
    Nurse(
      id: "N002",
      fullName: "Saavi",
      gender: "female",
      age: 40,
      contactNumber: "9876543211",
      email: "john@example.com",
      address: "456 Oak St, Town",
      qualification: "Diploma in Nursing",
      experience: 12,
      availability: "Night Shift",
      assignedLocation: "Community Clinic",
      services: ["Patient Care", "Emergency Response"],
      rating: 4.7,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nurse Services")),
      body: ListView.builder(
        itemCount: nurses.length,
        itemBuilder: (context, index) {
          return NurseCard(nurse: nurses[index]);
        },
      ),
    );
  }
}

class NurseCard extends StatefulWidget {
  final Nurse nurse;
  const NurseCard({Key? key, required this.nurse}) : super(key: key);

  @override
  _NurseCardState createState() => _NurseCardState();
}

class _NurseCardState extends State<NurseCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      widget.nurse.fullName[0],
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.nurse.fullName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(widget.nurse.qualification, style: const TextStyle(color: Colors.grey)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.call, color: Colors.green),
                    onPressed: () {
                      // Implement call functionality
                    },
                  )
                ],
              ),
              if (_isExpanded) ...[
                const Divider(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact: ${widget.nurse.contactNumber}"),
                      Text("Email: ${widget.nurse.email}"),
                      Text("Experience: ${widget.nurse.experience} years"),
                      Text("Availability: ${widget.nurse.availability}"),
                      Text("Location: ${widget.nurse.assignedLocation}"),
                      Text("Services: ${widget.nurse.services.join(', ')}"),
                      Text("Rating: ${widget.nurse.rating}"),
                    ],
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
