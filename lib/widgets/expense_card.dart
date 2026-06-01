import 'package:flutter/material.dart';

import '../models/expense_model.dart';

class ExpenseCard extends StatelessWidget {
  final Expense expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool isDark;

  const ExpenseCard({
    super.key,
    required this.expense,
    required this.onEdit,
    required this.onDelete,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),

      padding: const EdgeInsets.all(15),

      decoration: BoxDecoration(
        color: isDark ? Colors.grey.shade900 : Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
      ),

      child: Row(
        children: [
          CircleAvatar(
            radius: 28,

            backgroundColor: Colors.deepPurple.withOpacity(0.1),

            child: const Icon(Icons.wallet, color: Colors.deepPurple),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  expense.title,

                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,

                    color: isDark ? Colors.white : Colors.black,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  expense.category,

                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.grey,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  expense.date,

                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                "৳ ${expense.amount}",

                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,

                  color: isDark ? Colors.white : Colors.black,
                ),
              ),

              const SizedBox(height: 10),

              Row(
                mainAxisSize: MainAxisSize.min,

                children: [
                  GestureDetector(
                    onTap: onEdit,

                    child: Container(
                      padding: const EdgeInsets.all(6),

                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),

                  GestureDetector(
                    onTap: onDelete,

                    child: Container(
                      padding: const EdgeInsets.all(6),

                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),

                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: const Icon(
                        Icons.delete,
                        size: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
