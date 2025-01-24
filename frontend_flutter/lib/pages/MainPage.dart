import 'package:flutter/material.dart';
import 'package:flutter_catalog/pages/main_pages/history_page.dart';
import 'package:flutter_catalog/pages/main_pages/home_page.dart';
import 'package:flutter_catalog/pages/main_pages/profile_page.dart';
// import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List pages = [
    HomePage(), // index 0
    HistoryPage(), // index 1
    ProfilePage(), // index 2
  ];

  int selectedIndex = 0;

  void onTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     'PlantCare',
      //     style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
      //   ),
      //   backgroundColor: const Color(0xFF388E3C), // Lighter green for AppBar
      //   centerTitle: true,
      // ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color(0xFF2E7D32),
        // logic for bottom navigation bar items -> changing index
        onTap: (int index) {
          onTap(index);
        },
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
