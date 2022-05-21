import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/product_details_model/product_details.dart';
import '../../../data/repository/product_details_repository/product_details_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productDetailsRepository)
      : super(ProductDetailsInitial());

  bool isShowBasketIcon = true;
  int indicatorIndex = 0;

  void changeSmallPhotoIndex(int index) {
    indicatorIndex = index;
    emit(RefreshUi());
  }

  void changeShowBasketIcon({required bool isShow}) {
    isShowBasketIcon = isShow;
    log(isShowBasketIcon.toString());
    emit(RefreshUi());
  }

  ProductDetailsRepository productDetailsRepository;
  late ProductDetailsModel productDetailsModel;

  Future<void> getProductDetailsData({required int productId}) async {
    emit(ProductDetailsLoading());
    try {
      productDetailsModel = await productDetailsRepository
          .getProductDetailsData(productId: productId);
      emit(ProductDetailsSuccess());
    } catch (error, s) {
      log('get product detailsData error', error: error, stackTrace: s);

      emit(ProductDetailsError(error.toString()));
    }
  }
}
