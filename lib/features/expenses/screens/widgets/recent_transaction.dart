import 'package:flutter/material.dart';
import 'package:masroufy_app/core/const/app_colors.dart';

class TransactionTile extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final String? note;

  const TransactionTile({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.note
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [

          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryColor
                  .withOpacity(.1),
              borderRadius:
              BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.shopping_bag,
              color: AppColors.primaryColor,
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  note??"",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Column(
            children: [
              Text(
                '-$amount',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(date ,

              )
            ],
          ),
        ],
      ),
    );
  }
}