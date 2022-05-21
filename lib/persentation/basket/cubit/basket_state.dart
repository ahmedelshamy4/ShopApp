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

class BasketUpdateQuantityLoading extends BasketState {}

class BasketUpdateQuantitySuccess extends BasketState {}

class BasketUpdateQuantityError extends BasketState {
  final String message;
  BasketUpdateQuantityError(this.message);
}

class DeleteFromBasketLoading extends BasketState {}

class DeleteFromBasketSuccess extends BasketState {}

class DeleteFromBasketError extends BasketState {
  final String message;
  DeleteFromBasketError(this.message);
}
