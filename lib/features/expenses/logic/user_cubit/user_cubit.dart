import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';


import '../../data/services/user_services.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserService userService;

  UserCubit(this.userService) : super(const UserState());

  /// LOAD USER
  Future<void> loadUser() async {
    emit(state.copyWith(isLoading: true));

    try {
      final user = await userService.getUser();

      emit(state.copyWith(
        user: user,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        error: e.toString(),
      ));
    }
  }

  /// SAVE USER
  Future<void> saveUser(UserModel user) async {
    await userService.saveUser(user);

    emit(state.copyWith(user: user));
  }

  /// UPDATE AMOUNT (BALANCE)
  Future<void> updateAmount(double newAmount) async {
    if (state.user == null) return;

    final updatedUser = state.user!.copyWith(amount: newAmount);

    await userService.saveUser(updatedUser);

    emit(state.copyWith(user: updatedUser));
  }

  /// INCREASE BALANCE
  Future<void> addToBalance(double value) async {
    if (state.user == null) return;

    final newAmount = state.user!.amount + value;

    await updateAmount(newAmount);
  }

  /// DECREASE BALANCE
  Future<void> subtractFromBalance(double value) async {
    if (state.user == null) return;

    final newAmount = state.user!.amount - value;

    await updateAmount(newAmount);
  }
}