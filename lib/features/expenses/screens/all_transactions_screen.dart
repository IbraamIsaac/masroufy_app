import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'package:masroufy_app/features/expenses/logic/expense_cubit/expense_state.dart';
import 'package:masroufy_app/features/expenses/screens/widgets/recent_transaction.dart';

class AllTransactionsScreen extends StatefulWidget {
  const AllTransactionsScreen({super.key});

  @override
  State<AllTransactionsScreen> createState() => _AllTransactionsScreenState();
}

class _AllTransactionsScreenState extends State<AllTransactionsScreen> {
  @override

  void initState() {
    super.initState();

    context.read<ExpenseCubit>().getExpense();
  }

  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(title: const Text('All Transactions') ),



      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {

          return ListView.builder(
            itemCount: state.expenses.length,
            itemBuilder: (context, index) {
              final expense = state.expenses[index];
              return GestureDetector(
                onLongPress: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Expense'),
                      content: const Text('Are you sure?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel' ,style: TextStyle(color:Colors.green),),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete', style: TextStyle(color: Colors.red),),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    context.read<ExpenseCubit>().deleteExpense(expense.id);
                  }
                },
                child: TransactionTile(
                  title:state.expenses[index].category,
                  date: DateFormat('dd MMM yyyy')
                      .format(state.expenses[index].date),
                  amount:state.expenses[index].amount.toString(),
                  note: state.expenses[index].note,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
