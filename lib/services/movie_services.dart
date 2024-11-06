import 'package:dio/dio.dart';
import 'package:flickd_app/models/movie.dart';
import 'package:flickd_app/services/http_services.dart';
import 'package:get_it/get_it.dart';

class MovieServices {
  final GetIt getIt = GetIt.instance;
  HTTPService? _http;
  MovieServices() {
    _http = getIt.get<HTTPService>();
  }
  Future<List<Movie>> getPopularMovies({int? page}) async {
    Response response =
        await _http!.get('/movie/popular', query: {'page': page});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load popular movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies({int? page}) async {
    Response response =
        await _http!.get('/movie/upcoming', query: {'page': page});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load upcoming movies');
    }
  }

  Future<List<Movie>> searchMovies(String searchTerm, {int? page}) async {
    Response response = await _http!
        .get('/search/movies', query: {'query': searchTerm, 'page': page});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((movieData) {
        return Movie.fromJson(movieData);
      }).toList();
      return movies;
    } else {
      throw Exception('Couldn\'t load while performing search');
    }
  }
}
