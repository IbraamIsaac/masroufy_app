import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:masroufy_app/core/const/app_colors.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_state.dart';
import 'package:masroufy_app/features/expenses/screens/add_expense_screen.dart';
import 'package:masroufy_app/features/expenses/screens/all_transactions_screen.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/amount_field.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/category_items.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/recent_transaction.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/total_balance.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();

    context.read<ExpenseCubit>().getExpense();
  }

  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backGround,

      appBar: AppBar(
        backgroundColor: AppColors.backGround,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Expense Tracker",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryColor,
          ),
        ),
      ),

      body: SafeArea(

        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                /// TOTAL BALANCE
                Center(
                  child: Column(
                    children:  [
                    TotalBalance(),
                      SizedBox(height: 10),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// MONTHLY EXPENSE CARD
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Monthly Expense",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "November 2023",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          Icon(Icons.more_horiz, color: Colors.grey.shade700),
                        ],
                      ),

                      const SizedBox(height: 25),

                      /// PROGRESS CIRCLE
                      const Center(
                        child: CircularProgressIndicator(
                          value: 0.6,
                          strokeWidth: 10,
                          backgroundColor: Colors.grey,
                          color: AppColors.primaryColor,
                        ),
                      ),

                      const SizedBox(height: 30),

                      /// CATEGORIES
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CategoryItem(title: "Housing", percent: "65%"),
                          CategoryItem(title: "Dining", percent: "20%"),
                          CategoryItem(title: "Others", percent: "15%"),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                /// HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recent Transactions",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            const AllTransactionsScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'VIEW ALL',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),


                BlocBuilder<ExpenseCubit, ExpenseState>(
                  builder: (context, state) {
                    final lastExpenses =
                    state.expenses.length > 4
                        ? state.expenses.sublist(
                      state.expenses.length - 4,
                    )
                        : state.expenses;

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: lastExpenses.length,
                      itemBuilder: (context, index) {
                        final expense = lastExpenses[index];

                        return Column(
                          children: [
                            TransactionTile(
                              title: expense.category,
                              date: DateFormat('dd MMM yyyy')
                                  .format(state.expenses[index].date),
                              amount: expense.amount.toString(),
                              note: expense.note,
                            ),
                            const SizedBox(height: 15),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),

      /// FLOATING BUTTON
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddExpenseScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}