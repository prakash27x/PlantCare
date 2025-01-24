import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({super.key});

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  String generatedCaptcha = '';
  final TextEditingController captchaController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedCountry;
  String? selectedGender;

  final List<String> countries = [
    'Nepal',
    'Afghanistan',
    'Argentina',
    'Australia',
    'Bangladesh',
    'Bhutan',
    'Brazil',
    'Cambodia',
    'Canada',
    'Central African Republic',
    'China',
    'France',
    'Germany',
    'Ghana',
    'India',
    'Indonesia',
    'Israel',
    'Japan',
    'Kazakhstan',
    'Kenya',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Malaysia',
    'Maldives',
    'Myanmar (Burma)',
    'North Korea',
    'Pakistan',
    'Palestine',
    'Philippines',
    'Qatar',
    'Russia',
    'Saudi Arabia',
    'South Africa',
    'South Korea',
    'Sri Lanka',
    'Sudan',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Thailand',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uzbekistan',
    'Vietnam',
    'Yemen',
    'Zimbabwe',
  ];

  final List<String> genders = ['Male', 'Female', 'Other'];

  @override
  void initState() {
    super.initState();
    _generateCaptcha();
  }

  void _generateCaptcha() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    generatedCaptcha = List.generate(
        6, (index) => characters[random.nextInt(characters.length)]).join();
    setState(() {});
  }

  Future<void> registerUser() async {
    // Validate password match
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Passwords do not match!')),
      );
      return;
    }

    // Create user data
    final userData = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'gender': selectedGender,
      'country': selectedCountry,
    };

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse('http://192.168.1.118:8000/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account Created Successfully!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registration failed: ${response.body}'),
          ),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create Account',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: const OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.person, color: const Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedGender,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Choose Gender',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.wc, color: const Color(0xFF1B5E20)),
                  isDense: true,
                ),
                isExpanded: false,
                items: genders
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCountry,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCountry = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Choose Country',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.flag, color: const Color(0xFF1B5E20)),
                  isDense: true,
                ),
                isExpanded: false,
                items: countries
                    .map<DropdownMenuItem<String>>(
                      (String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email, color: const Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock, color: const Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  border: const OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.lock_outline, color: const Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the CAPTCHA:',
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFF1B5E20)),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      generatedCaptcha,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B5E20),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: const Color(0xFF1B5E20)),
                    onPressed: _generateCaptcha,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: captchaController,
                decoration: InputDecoration(
                  labelText: 'Enter CAPTCHA',
                  border: const OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.verified, color: const Color(0xFF1B5E20)),
                ),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  if (captchaController.text != generatedCaptcha) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Incorrect CAPTCHA!')),
                    );
                  } else {
                    registerUser();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                ),
                child: Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
