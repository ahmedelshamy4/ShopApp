import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/basket_model/get_basket_model.dart';
import '../../../data/models/product_details_model/product_details.dart';
import '../../../data/repository/product_details_repository/product_details_repository.dart';

part 'product_details_state.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit(this.productDetailsRepository)
      : super(ProductDetailsInitial());

  bool isShowBasketIcon = true;
  int indicatorIndex = 0;
  int productQuantity = 1;

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

  void productDetailsQuantity({
    bool isIncrement = false,
    bool resetQuantity = false,
  }) {
    if (resetQuantity) {
      productQuantity = 1;
    } else if (isIncrement) {
      productQuantity++;
    } else {
      if (productQuantity > 1) {
        productQuantity--;
      }
    }
    emit(RefreshUi());
  }

  bool isProductInCart(int id, List<Cart> cartItems) {
    for (int i = 0; i < cartItems.length; ++i) {
      if (cartItems[i].product.id == id) {
        return true;
      }
    }
    return false;
  }
}
