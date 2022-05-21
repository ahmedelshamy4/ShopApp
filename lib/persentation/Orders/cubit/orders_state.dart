part of 'orders_cubit.dart';

@immutable
abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersSuccess extends OrdersState {}

class OrdersError extends OrdersState {
  final String message;

  OrdersError(this.message);
}
