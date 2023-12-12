import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import the splash screen file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IOT APP',
      home: const SplashScreen(), // Display SplashScreen initially
    );
  }
}
