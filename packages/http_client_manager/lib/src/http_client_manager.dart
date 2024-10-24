import 'package:dio/dio.dart';
import 'package:http_client_manager/src/client/dio_client.dart';
import 'package:http_client_manager/src/config/refresh_token_config.dart';
import 'package:http_client_manager/src/storage/secure_token_storage.dart';

class HttpClientManager {
  factory HttpClientManager() {
    _instance ??= HttpClientManager._internal();
    return _instance!;
  }

  HttpClientManager._internal();

  static HttpClientManager? _instance;

  late final DioClient _dioClient;

  Future<HttpClientManager> init({
    required BaseOptions options,
    required RefreshTokenConfig refreshTokenConfig,
  }) async {
    /// Initialize secure storage for http requests
    await secureStorage.initialize();
    _dioClient = DioClient(options: options, config: refreshTokenConfig);
    return this;
  }

  void addInterceptors(List<Interceptor> interceptors) {
    _dioClient.dio.interceptors.addAll(interceptors);
  }

  DioClient get dioClient => _dioClient;
}
