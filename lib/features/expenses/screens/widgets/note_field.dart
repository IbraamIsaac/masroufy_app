import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import '../../../../core/const/app_colors.dart';

class NoteField extends StatelessWidget {
  const NoteField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NOTE',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
            color: AppColors.black,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          maxLines: 3,
          minLines: 1,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.black,
          ),
          decoration: const InputDecoration(
            hintText: 'What was this for?',
            hintStyle: TextStyle(
              fontSize: 15,
              color: Color(0xFFAAAAAA),
            ),
            border: InputBorder.none,
            isDense: true,
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (value) {
            context.read<ExpenseCubit>().changeNote(value);
          },
        ),
        const Divider(height: 1, color: Color(0xFFE0E0E0)),
      ],
    );
  }
}