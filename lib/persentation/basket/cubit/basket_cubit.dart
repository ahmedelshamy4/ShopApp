import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../data/models/basket_model/add_basket_model.dart';
import '../../../data/models/basket_model/get_basket_model.dart';
import '../../../data/repository/basket_repository/basket_repository.dart';
import 'package:meta/meta.dart';

part 'basket_state.dart';

class BasketCubit extends Cubit<BasketState> {
  BasketCubit(this.basketRepository) : super(BasketInitial());

  final BasketRepository basketRepository;
  late AddToBasketModel basketModel;
  late BasketGetOrdersModel myBasketOrders;

//add
  Future<void> addToBasketOrders({required int productId}) async {
    emit(AddToBasketLoading());
    try {
      basketModel = await basketRepository.addToBasketOrders(productId);
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
}
