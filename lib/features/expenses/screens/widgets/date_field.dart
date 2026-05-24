import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_state.dart';
import '../../../../core/const/app_colors.dart';

class DateField extends StatelessWidget {
  const DateField({super.key});

  String _formatDate(DateTime date) {
    return '${date.month.toString().padLeft(2, '0')}/'
        '${date.day.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  Future<void> _pickDate(BuildContext context) async {
    final currentDate = context.read<ExpenseCubit>().state.expense.date;

    final picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null && context.mounted) {
      context.read<ExpenseCubit>().changeDate(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      buildWhen: (prev, curr) =>
      prev.expense.date != curr.expense.date,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DATE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => _pickDate(context),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _formatDate(state.expense.date),
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.black,
                    size: 22,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Divider(height: 1, color: Color(0xFFE0E0E0)),
          ],
        );
      },
    );
  }
}