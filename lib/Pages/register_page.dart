import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController lastDonationDateController = TextEditingController();
  final TextEditingController healthConditionsController = TextEditingController();
  final TextEditingController preferredLocationController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String gender = "Male";
  String bloodGroup = "O+";
  String eligibleForNextDonation = "Yes";
  String donorStatus = "Active";
  bool isLoading = false;
  bool _obscurePassword = true;

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        final url = Uri.parse("https://medical-python.vercel.app/register_donor");
        // final url = Uri.parse("http://10.0.2.2:5000/register_donor");// for emulator
        final response = await http.post(
          url,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "name": nameController.text.trim(),
            "age": int.tryParse(ageController.text.trim()) ?? 0,
            "gender": gender,
            "blood_group": bloodGroup,
            "contact": contactController.text.trim(),
            "email": emailController.text.trim(),
            "address": addressController.text.trim(),
            "last_donation_date": lastDonationDateController.text.trim(),
            "eligible_next_donation": eligibleForNextDonation,
            "health_conditions": healthConditionsController.text.trim(),
            "preferred_location": preferredLocationController.text.trim(),
            "donor_status": donorStatus,
            "password": passwordController.text.trim(),
          }),
        );

        final responseData = jsonDecode(response.body);
        setState(() => isLoading = false);

        if (response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Registration Successful!")),
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(responseData["message"] ?? "Registration failed")),
          );
        }
      } catch (e) {
        setState(() => isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register as Blood Donor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildTextField("Full Name", nameController, icon: Icons.person),
              _buildTextField("Phone Number", contactController, isNumber: true, icon: Icons.phone),
              _buildTextField("Email Address", emailController, icon: Icons.email),
              _buildPasswordField("Password", passwordController),
              _buildPasswordField("Confirm Password", confirmPasswordController),
              _buildTextField("Age", ageController, isNumber: true, icon: Icons.calendar_today),
              _buildDropdownField("Gender", ["Male", "Female", "Other"], (value) => setState(() => gender = value!)),
              _buildDropdownField("Blood Group", ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
                      (value) => setState(() => bloodGroup = value!)),
              _buildTextField("Address", addressController, icon: Icons.location_on),
              _buildTextField("Last Donation Date (YYYY-MM-DD)", lastDonationDateController, icon: Icons.date_range),
              _buildDropdownField("Eligible for Next Donation", ["Yes", "No"],
                      (value) => setState(() => eligibleForNextDonation = value!)),
              _buildTextField("Health Conditions", healthConditionsController, icon: Icons.health_and_safety),
              _buildTextField("Preferred Donation Location", preferredLocationController, icon: Icons.map),
              _buildDropdownField("Donor Status", ["Active", "Inactive"], (value) => setState(() => donorStatus = value!)),

              SizedBox(height: 20),
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                onPressed: registerUser,
                child: Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isNumber = false, IconData? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: TextFormField(
        controller: controller,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
          labelText: label,
          border: UnderlineInputBorder(),
          prefixIcon: Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
            onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownField(String label, List<String> options, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: UnderlineInputBorder()),
        value: options.first,
        items: options.map((String value) => DropdownMenuItem(value: value, child: Text(value))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}