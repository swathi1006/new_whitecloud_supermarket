import 'package:flutter/material.dart';

class OfflineFallbackScreen extends StatelessWidget {
  final String imagePath = 'assets/images/white_supermarket_login.jpeg'; // Path to your custom image asset
  final String wifiImage = 'assets/images/notconnected.png';

  const OfflineFallbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Directionality(
      textDirection: TextDirection.ltr, // Explicitly set text direction
      child: Scaffold(
        body: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Wi-Fi Image
                  Image.asset(
                    wifiImage,
                    width: screenWidth * 0.2, // 20% of screen width
                    height: screenWidth * 0.2,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 10),
                  // Illustration Image
                  Image.asset(
                    imagePath,
                    width: screenWidth * 0.8, // 80% of screen width
                    height: screenHeight * 0.5, // 50% of screen height
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),
                  // Text Messages
                  const Text(
                    "You are offline.",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Please check your internet connection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
