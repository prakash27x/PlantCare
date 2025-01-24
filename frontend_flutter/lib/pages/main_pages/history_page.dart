import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  // List<dynamic> history = [];

  @override
  void initState() {
    super.initState();
    // fetchHistory();
  }

  // Future<void> fetchHistory() async {
  //   final response =
  //       await http.get(Uri.parse('http://your-api-url/get_history'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       history = json.decode(response.body);
  //     });
  //   } else {
  //     throw Exception('Failed to load history');
  //   }
  // }

  // Future<void> deleteHistory(int id) async {
  //   final response =
  //       await http.delete(Uri.parse('http://your-api-url/delete_history/$id'));

  //   if (response.statusCode == 200) {
  //     setState(() {
  //       history.removeWhere((item) => item['id'] == id);
  //     });
  //   } else {
  //     throw Exception('Failed to delete history');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        backgroundColor: const Color(0xFF2E7D32),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'No history available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
