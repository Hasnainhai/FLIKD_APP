import 'package:dio/dio.dart';
import 'package:flickd_app/models/app_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';

class HTTPService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  String? _base_url;
  String? _api_key;
  HTTPService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }
  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final url = '$_base_url$path';
      Map<String, dynamic> _query = {
        'api_key': _api_key,
        'language': 'en-US',
      };
      if (query != null) {
        _query.addAll(query);
      }
      return await dio.get(url, queryParameters: _query);
    } on DioException catch (e) {
      debugPrint('Unable to perform get req: ');
      debugPrint('DIOERROR :$e');
      return Response(
        requestOptions: RequestOptions(path: path),
        statusCode: 500,
        statusMessage: 'Error occurred',
      );
    }
  }
}
