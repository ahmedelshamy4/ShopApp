import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_shop_store/data/web_services/local/pref/user_pref.dart';
import 'package:meta/meta.dart';

import '../../../../data/repository/user_repository/logout.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit(this.logoutRepo) : super(LogoutInitial());

  final LogoutRepository logoutRepo;
  void signOut() {
    UserPrefs().deleteUserToken();
    emit(LogoutRefreshUi());
  }

  Future<void> userLogout() async {
    emit(LogoutLoadingState());
    try {
      await logoutRepo.userLogout();
      signOut();
      emit(LogoutSuccessState());
    } catch (error, s) {
      log('logout error', error: error, stackTrace: s);
      emit(LogoutErrorState(error.toString()));
    }
  }
}
