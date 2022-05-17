import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_store/data/models/login_model/login_model.dart';
import 'package:flutter_shop_store/data/repository/user_repository/register_repo.dart';

part 'singup_state.dart';

class SingupCubit extends Cubit<SingupState> {
  SingupCubit(this.registerRepo) : super(SingupInitial());

  final formKey = GlobalKey<FormState>();
  final registerNameControl = TextEditingController();
  final registerEmailControl = TextEditingController();
  final registerPhoneControl = TextEditingController();
  final registerPasswordControl = TextEditingController();
  final registerConfirmPasswordControl = TextEditingController();

  final RegisterRepository registerRepo;
  late LoginModel registerModel;

  Future<void> userRegister() async {
    emit(SingupLoadingState());
    try {
      registerModel = await registerRepo.userRegister(
        email: registerEmailControl.text,
        password: registerPasswordControl.text,
        name: registerNameControl.text,
        phone: registerPhoneControl.text,
      );
      emit(SingupSuccessState(registerModel));
    } catch (error, s) {
      log('user register', error: error, stackTrace: s);
      emit(SingupErrorState(error.toString()));
    }
  }

  bool isVisibility = true;
  void visibilityPassword() {
    isVisibility = !isVisibility;
    emit(SingupRefreshUi());
  }

  bool confirmNotVisible = true;
  void confirmVisiblePassword() {
    confirmNotVisible = !confirmNotVisible;
    emit(SingupRefreshUi());
  }
}
