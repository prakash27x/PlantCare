import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? _image; // To hold the captured image
  bool _isLoading = false; // To show the loading indicator

  // Function to open camera and capture image
  Future<void> _takePhoto(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image captured');
    }
  }

  // Function to pick image from gallery
  Future<void> _pickFromGallery(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    } else {
      print('No image selected');
    }
  }

  // Function to upload image to backend
  Future<void> _uploadImage(BuildContext context, File image) async {
    final Uri apiUrl = Uri.parse(
        'http://192.168.1.118:8000/api/upload-image'); // FastAPI server URL

    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    // Create a multipart request
    var request = http.MultipartRequest('POST', apiUrl);
    request.files.add(await http.MultipartFile.fromPath('file', image.path));

    try {
      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        // If the server returns a 200 response, parse the response
        final responseData = await response.stream.bytesToString();
        final responseJson = jsonDecode(responseData);

        // Navigate to the result page with the prediction results
        Navigator.pushNamed(context, '/result', arguments: responseJson);
      } else {
        // Handle error
        print('Failed to upload image');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      // Hide loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'PlantCare',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF388E3C), // Lighter green for AppBar
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Main content with buttons
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    _takePhoto(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.camera,
                          size: 36,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Scan Image',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    _pickFromGallery(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color(0xFF2E7D32),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          FontAwesomeIcons.upload,
                          size: 36,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Upload Image',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          if (_image != null)
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 280,
                  height: 380,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            size: 30,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            setState(() {
                              _image = null;
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          _uploadImage(context, _image!);
                        },
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.green,
                          child: Icon(
                            FontAwesomeIcons.search,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Loading indicator
          if (_isLoading)
            Container(
              color:
                  Colors.black.withOpacity(0.5), // Semi-transparent background
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
