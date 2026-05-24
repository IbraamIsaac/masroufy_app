import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/features/expenses/data/expense_service.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/expens_model.dart';
import '../user_cubit/user_cubit.dart';
import 'expense_state.dart';

class ExpenseCubit extends Cubit<ExpenseState> {
  ExpenseService expenseService=ExpenseService();
   final UserCubit userCubit ;
  ExpenseCubit(this.userCubit)
      : super(
    ExpenseState(

      expense: ExpenseModel(
        id: const Uuid().v4(),
        amount: 0.0,
        category: 'Food',
        date: DateTime.now(),
      ),

    ),
  );

  void changeCategory(String value) {
    emit(state.copyWith(
      expense: state.expense.copyWith(category: value),
    ));
  }

  void changeDate(DateTime value) {
    emit(state.copyWith(
      expense: state.expense.copyWith(date: value),
    ));
  }

  void changeAmount(double value) {
    emit(state.copyWith(
      expense: state.expense.copyWith(amount: value),
    ));
  }

  void changeNote(String value) {
    emit(state.copyWith(
      expense: state.expense.copyWith(note: value),
    ));
  }

  void changeReceiptImage(String path) {
    emit(state.copyWith(
      expense: state.expense.copyWith(receiptImagePath: path),
    ));
  }
  Future<void> addExpense(ExpenseModel expense) async {
    await expenseService.addExpense(expense);

    final updatedList = List<ExpenseModel>.from(state.expenses)
      ..add(expense);

    emit(state.copyWith(expenses: updatedList));
    userCubit.subtractFromBalance(expense.amount);

  }
  Future<void> deleteExpense(String id) async {
    final expenseToDelete = state.expenses.firstWhere(
          (expense) => expense.id == id,
    );

    await expenseService.deleteExpense(id);

    userCubit.addToBalance(expenseToDelete.amount);

    final updatedList = state.expenses
        .where((expense) => expense.id != id)
        .toList();

    emit(state.copyWith(expenses: updatedList));
  }
  Future< List<ExpenseModel>> getExpense() async{
    List<ExpenseModel> expenseList=await expenseService.getAllExpenses();
    emit( state.copyWith(expenses: expenseList));
    return expenseList;

   }

}