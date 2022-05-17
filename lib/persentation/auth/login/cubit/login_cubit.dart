import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_store/data/models/login_model/login_model.dart';
import 'package:flutter_shop_store/data/repository/user_repository/login_repo.dart';
import 'package:flutter_shop_store/data/web_services/local/pref/user_pref.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final LoginRepository loginRepo;
  late final LoginModel loginModel;

  Future<void> userLogin() async {
    emit(LoginLoadingState());
    try {
      loginModel = await loginRepo.userLogin(
          email: emailController.text, password: passwordController.text);
      await UserPrefs().setUserToken(loginModel.data.token);
      emit(LoginSuccessState(loginModel));
    } catch (e, s) {
      log('login error', error: e, stackTrace: s);
      emit(LoginErrorState(e.toString()));
    }
  }

  bool isVisibility = true;
  void visibilityPassword() {
    isVisibility = !isVisibility;
    emit(LoginRefreshUi());
  }
}
