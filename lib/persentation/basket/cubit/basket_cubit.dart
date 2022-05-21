import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../data/models/basket_model/add_basket_model.dart';
import '../../../data/models/basket_model/get_basket_model.dart';
import '../../../data/repository/basket_repository/basket_repository.dart';
import 'package:meta/meta.dart';

part 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit(this.basketRepository) : super(BasketInitial());

  BasketRepository basketRepository;
  late AddToBasketModel basketModel;
  late BasketGetOrdersModel myBasketOrders;

//add
  Future<void> addToBasketOrders(
      {required int productId, required int productQuantity}) async {
    emit(AddToBasketLoading());
    try {
      final value = await basketRepository.addToBasketOrders(productId);
      updateBasketOrderData(
        productId: value.data.id,
        quantity: productQuantity,
      );
      getMyBasketData();
      emit(AddToBasketSuccess());
    } catch (error, s) {
      log('add to basket orders data', error: error, stackTrace: s);
      emit(AddToBasketError(error.toString()));
    }
  }

//get
  Future<void> getMyBasketData() async {
    emit(BasketGetOrderLoading());
    try {
      myBasketOrders = await basketRepository.getBasketOrders();
      emit(BasketGetOrderSuccess());
    } catch (error, s) {
      log('get my  basket orders data', error: error, stackTrace: s);
      emit(BasketGetOrderError(error.toString()));
    }
  }

  //update quantity of orders in basket
  Future<void> updateBasketOrderData({
    required int productId,
    required int quantity,
  }) async {
    emit(BasketUpdateQuantityLoading());
    try {
      basketRepository.updateBasketOrderData(
        productId: productId,
        quantity: quantity,
      );
      getMyBasketData();
      emit(BasketUpdateQuantitySuccess());
    } catch (error, s) {
      log('update basket orders data', error: error, stackTrace: s);
      emit(BasketUpdateQuantityError(error.toString()));
    }
  }

  //delete orders from basket
  Future<void> deleteOrderFromBasketData({required int productId}) async {
    emit(DeleteFromBasketLoading());
    try {
      basketRepository.deleteOrderFromBasketData(productId: productId);
      emit(DeleteFromBasketSuccess());
      getMyBasketData();
    } catch (error, s) {
      log('delete basket orders data', error: error, stackTrace: s);
      emit(DeleteFromBasketError(error.toString()));
    }
  }

  void updateQuantityCart(int id, int productQuantity) {
    for (int i = 0; i < myBasketOrders.data.cartItems.length; i++) {
      if (myBasketOrders.data.cartItems[i].product.id == id) {
        updateBasketOrderData(
          productId: myBasketOrders.data.cartItems[i].id,
          quantity: productQuantity,
        );
        break;
      }
    }
    emit(AddToBasketRefreshUi());
  }
}
