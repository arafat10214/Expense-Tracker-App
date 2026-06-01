import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class TotalExpenseCard extends StatelessWidget {
  final double total;

  const TotalExpenseCard({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 130,
        borderRadius: 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.2),
            Colors.white38.withOpacity(0.2),
          ],
        ),
        borderGradient: LinearGradient(
          colors: [Colors.white24, Colors.white70],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Total Expense",
              style: TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 10),
            Text(
              "৳ ${total.toStringAsFixed(2)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
