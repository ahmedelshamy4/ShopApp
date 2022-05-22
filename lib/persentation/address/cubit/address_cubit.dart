import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop_store/data/models/address_model/add_new_address_model.dart';
import 'package:flutter_shop_store/data/models/address_model/get_address_model.dart';
import 'package:flutter_shop_store/data/repository/address_repository/address_repository.dart';
import 'package:meta/meta.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit(this.addressRepository) : super(AddressInitial());

  final formKey = GlobalKey<FormState>();
  TextEditingController cityControl = TextEditingController();
  TextEditingController addressDetailsControl = TextEditingController();
  TextEditingController regionControl = TextEditingController();
  TextEditingController buildingNumberControl = TextEditingController();
  TextEditingController notesAddressControl = TextEditingController();

  final AddressRepository addressRepository;
  late GetAddressModel addressModel;

//add AddressData
  Future<void> addNewAddressData() async {
    emit(AddAddressLoading());
    try {
      await addressRepository.addNewAddressData(
        buildingNumber: buildingNumberControl.text,
        city: cityControl.text,
        region: regionControl.text,
        details: addressDetailsControl.text,
        notes: notesAddressControl.text,
      );
      getMyAddressData();
      emit(AddAddressSuccess());
    } catch (e, s) {
      log('add new  address data', error: e.toString(), stackTrace: s);
      emit(AddAddressError(s.toString()));
    }
  }

//add AddressData
  Future<void> updateAddressData({
    required int addressId,
    required String buildingNumber,
    required String city,
    required String region,
    required String details,
    required String notes,
  }) async {
    emit(UpdateAddressLoading());
    try {
      await addressRepository.updateAddressData(
        addressId: addressId,
        name: buildingNumber,
        city: city,
        region: region,
        details: details,
        notes: notes,
      );
      getMyAddressData();
      emit(UpdateAddressSuccess());
    } catch (e, s) {
      log('update address data', error: e.toString(), stackTrace: s);
      emit(UpdateAddressError(e.toString()));
    }
  }

//get AddressData
  Future<void> getMyAddressData() async {
    emit(GetAddressLoading());
    try {
      addressModel = await addressRepository.getMyAddressData();
      emit(GetAddressSuccess());
    } catch (e, s) {
      log('add get my address data', error: e.toString(), stackTrace: s);
      emit(GetAddressError(s.toString()));
    }
  }

  //delete address
  Future<void> deleteAddressData({required int addressId}) async {
    emit(DeleteAddressLoading());
    try {
      await addressRepository.deleteAddressData(addressId: addressId);
      addressModel = await addressRepository.getMyAddressData();
      emit(DeleteAddressOrderSuccess());
    } catch (e, s) {
      log(s.toString());
      emit(DeleteAddressError());
    }
  }

  void clearTextFromField() {
    buildingNumberControl.clear();
    cityControl.clear();
    regionControl.clear();
    addressDetailsControl.clear();
    notesAddressControl.clear();
    emit(AddressRefreshUi());
  }

  void initialTextFromField({
    required String city,
    required String addressDetails,
    required String region,
    required String buildingNumber,
    required String notes,
  }) {
    cityControl = TextEditingController(text: city);
    addressDetailsControl = TextEditingController(text: addressDetails);
    regionControl = TextEditingController(text: region);
    buildingNumberControl = TextEditingController(text: buildingNumber);
    notesAddressControl = TextEditingController(text: notes);
    emit(AddressRefreshUi());
  }
}
