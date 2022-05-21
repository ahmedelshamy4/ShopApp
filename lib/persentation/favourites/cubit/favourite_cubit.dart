import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/models/favourite_model/favourites_model.dart';
import '../../../data/repository/favourite_repository/favourite_repository.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit(this.favouritesRepo) : super(FavouriteInitial());

  final FavouriteRepository favouritesRepo;
  late FavouritesModel favouritesModel;

  Future<void> getFavouritesData() async {
    emit(GetFavoritesLoading());
    try {
      favouritesModel = await favouritesRepo.getFavouritesData();
      emit(GetFavoritesSuccess());
    } catch (error, s) {
      log('get favourites data', error: error, stackTrace: s);
      emit(GetFavoritesError(error.toString()));
    }
  }

//post  fav Data
  Future<void> changeFavourites(int productId) async {
    emit(ChangeFavorites());
    try {
      await favouritesRepo.changeFavorites(productId);
      getFavouritesData();
      emit(ChangeFavoritesSuccess());
    } catch (error, s) {
      log('change favorites data', error: error, stackTrace: s);
      emit(ChangeFavoritesError(error.toString()));
    }
  }
}
