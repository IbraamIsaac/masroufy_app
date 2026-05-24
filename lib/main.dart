import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/expenses/data/services/user_services.dart';
import 'features/expenses/logic/expense_cubit/expense_cubit.dart';
import 'features/expenses/logic/nav_cubit.dart';
import 'features/expenses/logic/user_cubit/user_cubit.dart';

import 'features/expenses/screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (_) => UserCubit(UserService())..loadUser(),
        ),

        BlocProvider(create: (context) => NavCubit()),
        BlocProvider<ExpenseCubit>(
          create: (context) =>
              ExpenseCubit(context.read<UserCubit>())..getExpense(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainScreen(),
      ),
    );
  }
}
