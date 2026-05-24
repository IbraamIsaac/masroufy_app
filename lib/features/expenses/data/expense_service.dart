import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/expens_model.dart';

class ExpenseService {
  static const String _key = "expenses";


  Future<void> addExpense(ExpenseModel expense) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> existing = prefs.getStringList(_key) ?? [];

    existing.add(jsonEncode(expense.toMap()));

    await prefs.setStringList(_key, existing);

  }


  Future<List<ExpenseModel>> getAllExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(_key) ?? [];

    return data
        .map((item) => ExpenseModel.fromMap(jsonDecode(item)))
        .toList();
  }


  Future<void> deleteExpense(String id) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> data = prefs.getStringList(_key) ?? [];

    final updated = data.where((item) {
      final map = jsonDecode(item);
      return map['id'] != id;
    }).toList();

    await prefs.setStringList(_key, updated);
  }


  Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}