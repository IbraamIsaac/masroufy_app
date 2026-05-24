import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import '../../../../core/const/app_colors.dart';

class AmountField extends StatelessWidget {
  String name ;
   AmountField({super.key, required this.name});

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
           name,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'LE',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w500,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(width: 4),
            Expanded(
              child: TextField(
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d+\.?\d{0,2}')),
                ],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w400,
                  color: AppColors.black,
                ),
                decoration: const InputDecoration(
                  hintText: '0.00',
                  hintStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFFAAAAAA),
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  final amount = double.tryParse(value) ?? 0.0;
                  context.read<ExpenseCubit>().changeAmount(amount);
                },
              ),
            ),
          ],
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}