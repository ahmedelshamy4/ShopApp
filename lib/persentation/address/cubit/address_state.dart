part of 'address_cubit.dart';

@immutable
abstract class AddressState {}

class AddressInitial extends AddressState {}

class GetAddressLoading extends AddressState {}

class GetAddressSuccess extends AddressState {}

class GetAddressError extends AddressState {
  final String message;

  GetAddressError(this.message);
}

class AddAddressLoading extends AddressState {}

class AddAddressSuccess extends AddressState {}

class AddAddressError extends AddressState {
  final String message;

  AddAddressError(this.message);
}

class UpdateAddressLoading extends AddressState {}

class UpdateAddressSuccess extends AddressState {}

class UpdateAddressError extends AddressState {
  final String message;

  UpdateAddressError(this.message);
}

class AddressRefreshUi extends AddressState {}

class DeleteAddressLoading extends AddressState {}

class DeleteAddressOrderSuccess extends AddressState {}

class DeleteAddressError extends AddressState {}
