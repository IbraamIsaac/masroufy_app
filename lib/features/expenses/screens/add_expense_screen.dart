import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'package:masroufy_app/features/expenses/logic/user_cubit/user_cubit.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/amount_field.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/category_drop_down.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/date_field.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/note_field.dart';

import '../../../../core/const/app_colors.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGround,
      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryColor),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Expense',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 💰 SALARY INPUT (NEW)
                    const SizedBox(height: 25),

                    /// EXPENSE FIELDS
                    AmountField(name: 'AMOUNT'),
                    const SizedBox(height: 28),
                    const CategoryDropdown(),
                    const SizedBox(height: 28),
                    const DateField(),
                    const SizedBox(height: 28),
                    const NoteField(),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            /// SAVE BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    final expenseCubit = context.read<ExpenseCubit>();

                    final expense = expenseCubit.state.expense;

                    await expenseCubit.addExpense(expense);

                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: Colors.white,
                    size: 22,
                  ),
                  label: const Text(
                    'Save Expense',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
