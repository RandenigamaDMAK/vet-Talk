import 'package:flutter/material.dart';
import '../signup_page.dart';
import 'package:vet_talk/signup_page.dart' show SignupPage;

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Image section
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Image.asset(
                'assets/images/welcome.png',
                fit: BoxFit.contain,
              ),
            ),

            // Text section
            Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome to\nVet-Talk",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E2E42),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Community-powered care\nfor stray animals",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),

            // Button section
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: SizedBox(
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2E2E42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    );
                  },
                  child: const Text(
                    "Let’s GET STARTED !",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}