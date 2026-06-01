import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/expense_model.dart';

class StorageService {
  static const String key = "expenses";

  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();

    List<String> data = expenses.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, data);
  }

  static Future<List<Expense>> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    List<String>? data = prefs.getStringList(key);

    if (data != null) {
      return data.map((e) => Expense.fromJson(jsonDecode(e))).toList();
    }

    return [];
  }
}
