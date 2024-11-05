import 'package:flickd_app/models/main_page_data.dart';
import 'package:flickd_app/models/movie.dart';
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
      _movies = await _movieServices.getPopularMovies(page: state.page);
    } catch (e) {
      throw Exception('Error occure: $e');
    }
  }
}
