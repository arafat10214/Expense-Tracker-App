import 'package:flutter/material.dart';

import '../models/expense_model.dart';
import '../services/storage_service.dart';
import '../widgets/expense_card.dart';
import '../widgets/total_expense_card.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback toggleTheme;

  const HomeScreen({super.key, required this.toggleTheme});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Expense> expenses = [];

  bool isDark = false;

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> loadExpenses() async {
    expenses = await StorageService.loadExpenses();

    setState(() {});
  }

  Future<void> saveExpenses() async {
    await StorageService.saveExpenses(expenses);
  }

  double get totalExpense {
    double total = 0;

    for (var expense in expenses) {
      total += expense.amount;
    }

    return total;
  }

  void addExpense(Expense expense) {
    expenses.add(expense);

    saveExpenses();

    setState(() {});
  }

  void deleteExpense(int index) {
    expenses.removeAt(index);

    saveExpenses();

    setState(() {});
  }

  void editExpense(int index, Expense expense) {
    expenses[index] = expense;

    saveExpenses();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: isDark ? Colors.white : Colors.white,

        child: const Icon(Icons.add, color: Colors.black),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
          );

          if (result != null) {
            addExpense(result);
          }
        },
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,

            colors: isDark
                ? [const Color(0xff000000), const Color(0xff1A1A1A)]
                : [const Color(0xff6A11CB), const Color(0xff2575FC)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  "Expense Tracker",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                centerTitle: true,

                backgroundColor: Colors.transparent,

                elevation: 0,

                actions: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isDark = !isDark;
                      });

                      widget.toggleTheme();
                    },

                    icon: Icon(
                      isDark ? Icons.light_mode : Icons.dark_mode,

                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              TotalExpenseCard(total: totalExpense),

              Expanded(
                child: expenses.isEmpty
                    ? const Center(
                        child: Text(
                          "No Expenses Added",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),

                        itemCount: expenses.length,

                        itemBuilder: (context, index) {
                          final expense = expenses[index];

                          return ExpenseCard(
                            expense: expense,

                            isDark: isDark,

                            onDelete: () {
                              deleteExpense(index);
                            },

                            onEdit: () async {
                              final result = await Navigator.push(
                                context,

                                MaterialPageRoute(
                                  builder: (_) =>
                                      AddExpenseScreen(expense: expense),
                                ),
                              );

                              if (result != null) {
                                editExpense(index, result);
                              }
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
