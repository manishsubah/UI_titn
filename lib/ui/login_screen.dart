import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  "assets/images/bg_login_top.png",
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                // Positioned(
                //   top: 250,
                //     left: 0,
                //     right: 0,
                //     child: Image.asset("assets/images/rectangle_login.png",
                //       width: double.infinity,
                //       fit: BoxFit.cover, color: Colors.green,
                //     ),
                // ),
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7F8FB),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        "assets/images/titan_logo.png",
                        height: 60,
                      ),
                      const SizedBox(height: 8),

                      // Title
                      const Text(
                        "Log in Your Account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1B1B1B),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Email Field
                      TextField(
                        decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "example@mail.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Password Field
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "XXXXXXXX",
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.visibility_off),
                            onPressed: () {
                              // Toggle password visibility
                              setState(() {
                                // Logic to toggle visibility
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Keep me logged in
                      Row(
                        children: [
                          Checkbox(
                            value: true, // Replace with a state variable
                            onChanged: (bool? value) {
                              // Handle checkbox state change
                              setState(() {
                                // Logic to update checkbox state
                              });
                            },
                          ),
                          const Text("Keep me logged in"),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Log In button
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Log In",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Update Configuration Button
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.settings),
                        label: const Text("Update Configuration"),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }
}