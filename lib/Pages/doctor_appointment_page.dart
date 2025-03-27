import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class DoctorAppointmentPage extends StatefulWidget {
  @override
  _DoctorAppointmentPageState createState() => _DoctorAppointmentPageState();
}

class _DoctorAppointmentPageState extends State<DoctorAppointmentPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _medicationController = TextEditingController();
  File? _document;

  Future<void> _pickDocument() async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      setState(() {
        _document = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text =
            "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
      });
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("http://medical-python.vercel.app/book_appointment"),
      );

      request.fields['name'] = _nameController.text;
      request.fields['date'] = _dateController.text;
      request.fields['time'] = _timeController.text;
      request.fields['medication_details'] = _medicationController.text;

      if (_document != null) {
        request.files.add(
          await http.MultipartFile.fromPath('document', _document!.path),
        );
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Appointment booked successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to book appointment. Try again!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Doctor Appointment")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Patient Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: "Appointment Date",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: _selectDate,
                    ),
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: "Appointment Time",
                    suffixIcon: IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: _selectTime,
                    ),
                  ),
                  readOnly: true,
                ),
                TextFormField(
                  controller: _medicationController,
                  decoration: InputDecoration(labelText: "Medication Details"),
                ),
                SizedBox(height: 10),
                _document == null
                    ? Text("No document selected")
                    : Text("Document selected"),
                ElevatedButton(
                  onPressed: _pickDocument,
                  child: Text("Upload Document"),
                ),
                SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    child: Text("Book Appointment"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
