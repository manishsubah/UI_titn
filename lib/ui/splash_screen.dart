import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: SafeArea(
        child: Column(
          children: [
            // Top Illustration Image
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/images/bg_login_top.png', // replace with your image asset
              width: 600,
              height: screenHeight * 0.4, // Adjust height as needed
              fit: BoxFit.contain,
            ),
            SizedBox(height: screenHeight * 0.05), // small gap

            // Card-like section for text & button
            Expanded(
              child: Container(
                width: double.infinity,
                height: 250, // Fixed height for the card
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F6FA), // Light grey background
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    const Text(
                      "Welcome to",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Logo and text
                    Column(
                      children: [
                        SvgPicture.asset(
                          'assets/images/titan_logo_new.svg', // replace with your logo asset
                          height: 50,
                        ),
                        const SizedBox(height: 5),
                        // const Text(
                        //   "Test Brilliantly",
                        //   style: TextStyle(
                        //     fontSize: 14,
                        //     fontStyle: FontStyle.italic,
                        //     color: Colors.black54,
                        //   ),
                        // ),
                      ],
                    ),

                    const SizedBox(height: 25),

                    // Get Started Button
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Navigate to next page
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF007BFF), // Blue button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
