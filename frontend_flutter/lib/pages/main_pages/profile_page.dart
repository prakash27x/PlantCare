import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = false; // Set this based on your login check logic

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF388E3C),
        centerTitle: true,
      ),
      body: Center(
        child: isLoggedIn
            ? SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Profile Picture
                      Center(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(
                              'assets/profile_placeholder.png'), // Replace with actual profile image
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  backgroundColor: const Color(0xFF388E3C),
                                  radius: 15,
                                  child: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // User Name
                      Text(
                        'John Doe', // Replace with dynamic data if available
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Email
                      Text(
                        'johndoe@example.com', // Replace with dynamic data if available
                        style: GoogleFonts.openSans(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 20),

                      Divider(color: Colors.grey[300], thickness: 1),
                      const SizedBox(height: 20),

                      // User Details
                      buildProfileRow(Icons.location_on, 'Location', 'Nepal'),
                      const SizedBox(height: 20),
                      buildProfileRow(Icons.calendar_today, 'Joined', '2025'),

                      const SizedBox(height: 40),

                      // Edit Profile Button
                      ElevatedButton.icon(
                        onPressed: () {
                          // Implement edit functionality here
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    "Edit profile feature is not implemented yet!")),
                          );
                        },
                        icon: const Icon(Icons.edit),
                        label: Text(
                          'Edit Profile',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF388E3C),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.account_circle,
                      size: 100, color: Color(0xFF388E3C)),
                  const SizedBox(height: 20),
                  Text(
                    'Please log in to view your profile.',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Navigate to the login/signup page
                      Navigator.pushNamed(
                          context, '/login'); // Replace with your actual route
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF388E3C),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  // Helper widget for profile detail rows
  Widget buildProfileRow(IconData icon, String title, String value) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF388E3C),
          size: 24,
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              value,
              style: GoogleFonts.openSans(
                fontSize: 14,
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
