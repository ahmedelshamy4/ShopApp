import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_store/shared/constants/constant.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../data/models/login_model/profile.dart';
import '../../../data/repository/user_repository/profile_repo.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(this.updateProfileRepository)
      : super(UpdateProfileInitial());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController(text: userData.data.name);
  final emailController = TextEditingController(text: userData.data.email);
  final phoneController = TextEditingController(text: userData.data.phone);

  final ProfileRepository updateProfileRepository;
  String? imageProfile;
  // update profile
  Future<void> updateUserData() async {
    emit(UpdateProfileLoading());
    try {
      userData = await updateProfileRepository.updateUserData(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        image: imageProfile,
      );
      emit(UpdateProfileSuccess(userData));
    } catch (error, s) {
      log('update user data', error: error, stackTrace: s);

      emit(UpdateProfileError(error.toString()));
    }
  }

  final ImagePicker imagePicker = ImagePicker();
  // take photo from camera
  Future getImageFromCamera() async {
    emit(GetCameraImageLoading());
    try {
      final XFile? photo =
          await imagePicker.pickImage(source: ImageSource.camera);
      convertPhotoToBase64(photo);
      emit(GetCameraImageSuccess());
    } catch (error, s) {
      log('get image from camera', error: error, stackTrace: s);
      emit(GetCameraImageError(error.toString()));
    }
  }

  File? tempImage;
  //convert Photo To Base64
  Future convertPhotoToBase64(dynamic myFileImage) async {
    // ignore: avoid_dynamic_calls
    tempImage = File(myFileImage.path.toString());
    final List<int> fileInByte = tempImage!.readAsBytesSync();
    final String fileInBase64 = base64Encode(fileInByte);
    imageProfile = fileInBase64;
  }

  // take photo from Gallery
  Future getImageFromGallery() async {
    emit(GetGalleryImageLoading());
    try {
      final XFile? photo =
          await imagePicker.pickImage(source: ImageSource.gallery);
      convertPhotoToBase64(photo);
      emit(GetGalleryImageSuccess());
    } catch (error, s) {
      log('get image from camera', error: error, stackTrace: s);
      emit(GetGalleryImageError(error.toString()));
    }
  }
}
