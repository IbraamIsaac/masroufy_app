import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/const/app_colors.dart';
import '../../logic/user_cubit/user_cubit.dart';
import '../../logic/user_cubit/user_state.dart';

class TotalBalance extends StatelessWidget {
  const TotalBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final amount = state.user?.amount ?? 0.0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'TOTAL BALANCE',
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

                const SizedBox(width: 6),

                Text(
                  amount.toStringAsFixed(2),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),

            const Divider(
              height: 1,
              color: Color(0xFFE0E0E0),
            ),
          ],
        );
      },
    );
  }
}