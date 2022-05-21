part of 'basket_cubit.dart';

@immutable
abstract class BasketState {}

class BasketInitial extends BasketState {}

class AddToBasketRefreshUi extends BasketState {}

class AddToBasketLoading extends BasketState {}

class AddToBasketSuccess extends BasketState {}

class AddToBasketError extends BasketState {
  final String message;
  AddToBasketError(this.message);
}

class BasketGetOrderLoading extends BasketState {}

class BasketGetOrderSuccess extends BasketState {}

class BasketGetOrderError extends BasketState {
  final String message;
  BasketGetOrderError(this.message);
}
