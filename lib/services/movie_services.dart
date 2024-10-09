import 'package:flickd_app/services/http_services.dart';
import 'package:get_it/get_it.dart';

class MovieServices {
  final GetIt getIt = GetIt.instance;
  HTTPService? _http;
  MovieServices() {
    _http = getIt.get<HTTPService>();
  }
}
