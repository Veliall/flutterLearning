import 'package:flutter/material.dart';
import 'package:static_widgets/basic_screen.dart';

void main() {
  runApp(StaticApp());
}

class StaticApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BasicScreen(),
    );
  }
}
