part of 'favourite_cubit.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class GetFavoritesLoading extends FavouriteState {}

class GetFavoritesSuccess extends FavouriteState {}

class GetFavoritesError extends FavouriteState {
  final String message;

  GetFavoritesError(this.message);
}

class ChangeFavorites extends FavouriteState {}

class ChangeFavoritesSuccess extends FavouriteState {}

class ChangeFavoritesError extends FavouriteState {
  final String message;

  ChangeFavoritesError(this.message);
}
