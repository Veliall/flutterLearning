import 'package:dog_profile/flex_screen.dart';
import 'package:dog_profile/profile_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile Screen',
      home: FlexScreen(),
      // home: ProfileScreen(),
    );
  }
}
