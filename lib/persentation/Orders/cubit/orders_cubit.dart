import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/orders_model/orders_model.dart';
import '../../../data/repository/orders_repository/orders_Repository.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.ordersRepository) : super(OrdersInitial());

  final OrdersRepository ordersRepository;
  late OrdersModel ordersModel;

  Future<void> getOrder() async {
    emit(OrdersLoading());
    try {
      ordersModel = await ordersRepository.getOrder();
      emit(OrdersSuccess());
    } catch (error, s) {
      emit(
        OrdersError(error.toString()),
      );
      log('get Orders data', error: error, stackTrace: s);
    }
  }
}
