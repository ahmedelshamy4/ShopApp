part of 'singup_cubit.dart';

@immutable
abstract class SingupState {}

class SingupInitial extends SingupState {}

class SingupLoadingState extends SingupState {}

class SingupSuccessState extends SingupState {
  final LoginModel model;
  SingupSuccessState(this.model);
}

class SingupErrorState extends SingupState {
  final String error;
  SingupErrorState(this.error);
}

class SingupRefreshUi extends SingupState {}
