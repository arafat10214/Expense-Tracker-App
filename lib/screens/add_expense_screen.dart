import 'package:expense_tracker_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:intl/intl.dart';

import '../models/expense_model.dart';
import '../widgets/custom_button.dart';

class AddExpenseScreen extends StatefulWidget {
  final Expense? expense;

  const AddExpenseScreen({super.key, this.expense});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();

  final amountController = TextEditingController();

  final descriptionController = TextEditingController();

  String category = "Food";

  String date = "";

  @override
  void initState() {
    super.initState();

    if (widget.expense != null) {
      titleController.text = widget.expense!.title;

      amountController.text = widget.expense!.amount.toString();

      descriptionController.text = widget.expense!.description;

      category = widget.expense!.category;

      date = widget.expense!.date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xff6A11CB), Color(0xff2575FC)],
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      widget.expense == null ? "Add Expense" : "Edit Expense",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: GlassmorphicContainer(
                    width: double.infinity,
                    height: double.infinity,
                    borderRadius: 30,
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

                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: formKey,
                        child: ListView(
                          children: [
                            const SizedBox(height: 10),

                            CustomTextField(
                              controller: titleController,
                              label: "Expense Title",
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                              controller: amountController,
                              label: "Amount",
                              keyboardType: TextInputType.number,
                            ),

                            const SizedBox(height: 20),

                            DropdownButtonFormField(
                              value: category,

                              dropdownColor: Colors.deepPurple,

                              style: const TextStyle(color: Colors.white),

                              decoration: InputDecoration(
                                labelText: "Category",

                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              items: const [
                                DropdownMenuItem(
                                  value: "Food",
                                  child: Text("Food"),
                                ),

                                DropdownMenuItem(
                                  value: "Shopping",
                                  child: Text("Shopping"),
                                ),

                                DropdownMenuItem(
                                  value: "Travel",
                                  child: Text("Travel"),
                                ),

                                DropdownMenuItem(
                                  value: "Entertainment",
                                  child: Text("Entertainment"),
                                ),
                              ],

                              onChanged: (value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                            ),

                            const SizedBox(height: 20),

                            TextFormField(
                              readOnly: true,

                              style: const TextStyle(color: Colors.white),

                              decoration: InputDecoration(
                                labelText: date.isEmpty ? "Select Date" : date,

                                labelStyle: const TextStyle(
                                  color: Colors.white,
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),

                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),

                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                  color: Colors.white,
                                ),
                              ),

                              onTap: () async {
                                DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2030),
                                );

                                if (picked != null) {
                                  setState(() {
                                    date = DateFormat.yMMMd().format(picked);
                                  });
                                }
                              },
                            ),

                            const SizedBox(height: 20),

                            CustomTextField(
                              controller: descriptionController,
                              label: "Description",
                              maxLines: 4,
                            ),

                            const SizedBox(height: 30),

                            CustomButton(
                              title: "Save Expense",

                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  Expense expense = Expense(
                                    title: titleController.text,

                                    amount: double.parse(amountController.text),

                                    category: category,

                                    date: date,

                                    description: descriptionController.text,
                                  );

                                  Navigator.pop(context, expense);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
