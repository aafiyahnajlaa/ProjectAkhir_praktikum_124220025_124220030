import 'package:appbook/pages/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:appbook/auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:appbook/firebase_options.dart';
import 'dart:async';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 4),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color.fromARGB(255, 2, 85, 6), // Dark green
              const Color.fromARGB(255, 188, 255, 152), // Light yellow
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white, // Background color of the round profile
                ),
                padding: const EdgeInsets.all(20), // Padding around the icon
                child: const Icon(
                  Icons.menu_book, // Use the forest icon
                  size: 80,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 20), // Spacing between icon and text
              const Text(
                'E-BOOK APPS',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Text color
                ),
              ),
              const SizedBox(height: 20), // Spacing between text and loading icon
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}