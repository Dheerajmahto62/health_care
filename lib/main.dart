import 'package:flutter/material.dart';
import 'pages/camp_list_page.dart';
import 'pages/map_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Camp Finder',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: CampListPage(), // Default Home Screen
      routes: {
        '/map': (context) => MapScreen(), // Navigate to Map Screen
        '/camps': (context) => CampListPage(), // Navigate to Camp List
      },
    );
  }
}
