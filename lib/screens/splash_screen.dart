import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  const SplashScreen({super.key, required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.account_balance_wallet, size: 100, color: Colors.white),
          SizedBox(height: 20),
          Text(
            "Expense Tracker",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      nextScreen: HomeScreen(toggleTheme: toggleTheme),
      splashIconSize: 250,
      backgroundColor: Colors.deepPurple,
      duration: 2500,
    );
  }
}
