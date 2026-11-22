import 'package:dio/dio.dart';

class DioConfig {
  DioConfig._();

  static const String viaCepBaseUrl = 'https://viacep.com.br/ws';

  static Dio createClient() {
    final options = BaseOptions(
      baseUrl: viaCepBaseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    return Dio(options);
  }
}
