
import 'package:flutter/material.dart';
import 'package:masroufy_app/core/const/app_colors.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String percent;

  const CategoryItem({super.key, required this.title, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primaryColor,
          ),
        ),

        const SizedBox(width: 8),

        Text(title),

        const SizedBox(width: 5),

        Text(percent, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
