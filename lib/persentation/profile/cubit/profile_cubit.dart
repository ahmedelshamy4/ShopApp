import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/repository/user_repository/profile_repo.dart';
import '../../../shared/constants/constant.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  final ProfileRepository profileRepository;

  Future<void> getUserData() async {
    emit(ProfileLoading());
    try {
      userData = await profileRepository.getUserData();
      emit(ProfileSuccess());
    } catch (error, s) {
      log('get user data', error: error, stackTrace: s);
      emit(ProfileError(error.toString()));
    }
  }
}
