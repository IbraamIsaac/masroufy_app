// lib/features/expenses/screens/main_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:masroufy_app/core/const/app_colors.dart';
import 'package:masroufy_app/features/expenses/screens/all_transactions_screen.dart';
import 'package:masroufy_app/features/expenses/screens/home_screen.dart';


import '../logic/nav_cubit.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> _screens = const [
    HomeScreen(),
    AllTransactionsScreen(),
    Scaffold(body: Center(child: Text("Profile"))),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavCubit(),
      child: BlocBuilder<NavCubit, int>(
        builder: (context, currentIndex) {
          return Scaffold(
            body: _screens[currentIndex],
            bottomNavigationBar: _BottomNavBar(currentIndex: currentIndex),
          );
        },
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  final int currentIndex;
  const _BottomNavBar({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _NavItem(index: 0, icon: Icons.grid_view_rounded, label: 'Dashboard', currentIndex: currentIndex),
          _NavItem(index: 1, icon: Icons.list_alt, label: 'All trans', currentIndex: currentIndex),
          _NavItem(index: 2, icon: Icons.person_outline_rounded, label: 'Profile', currentIndex: currentIndex),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final String label;

  const _NavItem({
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => context.read<NavCubit>().changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primaryColor : Colors.grey,
              size: 22,
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: isSelected
                  ? Row(
                children: [
                  const SizedBox(width: 6),
                  Text(
                    label,
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ],
              )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}