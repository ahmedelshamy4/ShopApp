import 'dart:developer';

import 'package:bloc/bloc.dart';

import '../../../data/models/home_model/banner_model.dart';
import '../../../data/models/home_model/categories_model.dart';
import '../../../data/models/home_model/product_model.dart';
import '../../../data/repository/home_repository/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepos) : super(HomeInitial());

  final HomeRepository homeRepos;

  late HomeModel homeModel;
  late BannerModel bannerModel;
  late CategoriesModel categoriesModel;
  late Map<int, bool> favourites = {};

  Future<void> getHomeData() async {
    emit(HomeLoading());
    try {
      homeModel = await homeRepos.getHomeData();
      bannerModel = await homeRepos.getBannerData();
      categoriesModel = await homeRepos.getCategoriesData();
      for (final element in homeModel.data.productData) {
        favourites.addAll({
          element.id: element.isFavorite,
        });
      }
      emit(HomeSuccess());
    } catch (error, s) {
      log('get home data error', error: error, stackTrace: s);
      emit(HomeError(error.toString()));
    }
  }

  int quantityProduct = 1;
  void incrementOrder() {
    quantityProduct++;
    emit(HomeRefreshUi());
  }

  void decrementOrder() {
    if (quantityProduct != 1) quantityProduct--;
    emit(HomeRefreshUi());
  }

  int indicatorIndex = 4;
  void changeBannerIndex(int index) {
    indicatorIndex = index;
    emit(HomeRefreshUi());
  }

  int indicatorIndexCategory = 5;
  void changeCategoryIndex(int index) {
    indicatorIndexCategory = index;
    emit(HomeRefreshUi());
  }

  void changeHomeFavourites(int id) {
    favourites[id] = !favourites[id]!;
    emit(HomeRefreshUi());
  }
}
