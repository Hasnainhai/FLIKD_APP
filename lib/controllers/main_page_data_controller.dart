import 'package:flickd_app/models/main_page_data.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/models/search_category.dart';
import 'package:flickd_app/services/movie_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
      : super(state ?? MainPageData.inital()) {
    getMovies();
  }
  final MovieServices _movieServices = GetIt.instance.get<MovieServices>();
  Future<void> getMovies() async {
    try {
      List<Movie> _movies = [];
      if (state.searchText.isEmpty) {
        if (state.searchCategory == SearchCategory.popular) {
          _movies = await _movieServices.getPopularMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.upComing) {
          _movies = await _movieServices.getUpcomingMovies(page: state.page);
        } else if (state.searchCategory == SearchCategory.none) {
          _movies = [];
        }
      } else {
        _movies = await _movieServices.searchMovies(state.searchText);
      }
      state = state.copyWith(
          movies: [...state.movies, ..._movies],
          page: state.page + 1,
          searchCategory: state.searchCategory,
          searchText: state.searchText);
    } catch (e) {
      throw Exception('Error occure: $e');
    }
  }

  void updateSearchCategories(String category) async {
    try {
      state = state.copyWith(
          movies: [], page: 1, searchCategory: category, searchText: '');
      getMovies();
    } catch (e) {
      print('$e');
    }
  }

  void updateTextSearch(String searchText) async {
    try {
      state = state.copyWith(
          movies: [],
          page: 1,
          searchCategory: SearchCategory.none,
          searchText: searchText);
      getMovies();
    } catch (e) {
      print('$e');
    }
  }
}
