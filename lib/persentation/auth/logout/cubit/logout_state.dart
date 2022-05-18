part of 'logout_cubit.dart';

@immutable
abstract class LogoutState {}

class LogoutInitial extends LogoutState {}

class LogoutLoadingState extends LogoutState {}

class LogoutSuccessState extends LogoutState {}

class LogoutRefreshUi extends LogoutState {}

class LogoutErrorState extends LogoutState {
  final String message;

  LogoutErrorState(this.message);
}
