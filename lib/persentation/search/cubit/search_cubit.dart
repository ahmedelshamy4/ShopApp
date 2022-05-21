import 'dart:developer';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import '../../../data/models/search_model.dart/search_model.dart';
import '../../../data/repository/search_repository/search_repository.dart';
import 'package:meta/meta.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchRepository) : super(SearchInitial());

  SearchRepository searchRepository;
  SearchModel? searchModel;

  Future<void> getSearchData({required String text}) async {
    emit(SearchLoading());
    try {
      searchModel = await searchRepository.getSearchData(text: text);
      emit(SearchSuccess());
    } catch (error, s) {
      log('get search data', error: error, stackTrace: s);
      emit(SearchError(error.toString()));
    }
  }

  void resetSearch() {
    searchModel = null;
    emit(SearchRefreshUi());
  }
}
