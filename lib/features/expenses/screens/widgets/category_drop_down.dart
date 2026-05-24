import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_state.dart';
import '../../../../core/const/app_colors.dart';

class CategoryDropdown extends StatelessWidget {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseCubit, ExpenseState>(
      buildWhen: (prev, curr) =>
      prev.expense.category != curr.expense.category,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'CATEGORY',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: AppColors.black,
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFFE0E0E0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: state.expense.category,
                  isExpanded: true,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.black,
                  ),
                  items: ['Food', 'Transport', 'Shopping', 'Others']
                      .map(
                        (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(
                        cat,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.black,
                        ),
                      ),
                    ),
                  )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      context.read<ExpenseCubit>().changeCategory(value);
                    }
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}