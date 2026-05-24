

import '../../data/models/expens_model.dart';

class ExpenseState {
  final ExpenseModel expense;
  final List<ExpenseModel> expenses;
  const ExpenseState({required this.expense, this.expenses=const []});

  ExpenseState copyWith({ExpenseModel? expense, List<ExpenseModel>?expenses}) {
    return ExpenseState(
      expense: expense ?? this.expense,
      expenses: expenses ??this.expenses,
    );
  }
}