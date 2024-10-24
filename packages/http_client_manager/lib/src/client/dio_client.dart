import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fresh_dio/fresh_dio.dart';
import 'package:http_client_manager/src/config/refresh_token_config.dart';
import 'package:http_client_manager/src/extensions/o_auth_2_extension.dart';
import 'package:http_client_manager/src/interceptor/http_header_interceptor.dart';
import 'package:http_client_manager/src/storage/secure_token_storage.dart';

class DioClient {
  factory DioClient({BaseOptions? options, RefreshTokenConfig? config}) =>
      _instance ?? DioClient._internal(options: options, config: config);

  DioClient._internal({
    BaseOptions? options,
    RefreshTokenConfig? config,
  }) {
    _dio = Dio(options ?? BaseOptions());

    _fresh = Fresh.oAuth2(
      tokenStorage: secureStorage,
      shouldRefresh: (response) {
        if (response == null) return false;
        return response.statusCode == 401;
      },
      refreshToken: (token, client) async {
        _activeRefreshTokenFuture ??=
            refreshToken(reqToken: token, config: config).whenComplete(() {
          _activeRefreshTokenFuture = null;
        });
        return _activeRefreshTokenFuture!;
      },
    );
    _dio.interceptors.add(_fresh);
    _dio.interceptors.add(HttpHeaderInterceptor());
  }

  Future<OAuth2Token>? _activeRefreshTokenFuture;

  static DioClient? _instance;

  late final Dio _dio;

  late Fresh<OAuth2Token> _fresh;

  Future<Response<Map<String, dynamic>>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
  }) async {
    return _dio.get(url, queryParameters: queryParameters);
  }

  Future<Response<Map<String, dynamic>>> post(
    String url, {
    required Map<String, dynamic> queryParameters,
    required bool isPublic,
    Map<String, dynamic>? data,
  }) async {
    return _dio.post(
      url,
      queryParameters: queryParameters,
      data: data,
      options: Options(
        extra: {
          'isPublic': isPublic,
        },
      ),
    );
  }

  Future<Response<Map<String, dynamic>>> put(
    String url, {
    required Map<String, dynamic> queryParameters,
  }) async {
    return _dio.put(url, queryParameters: queryParameters);
  }

  Future<Response<Map<String, dynamic>>> delete(
    String url, {
    required Map<String, dynamic> queryParameters,
  }) async {
    return _dio.delete(url, queryParameters: queryParameters);
  }

  Future<OAuth2Token> refreshToken({
    OAuth2Token? reqToken,
    RefreshTokenConfig? config,
  }) async {
    if (config == null) {
      throw Exception('HttpClientConfig is required for'
          ' refreshing token');
    }
    final result = await post(
      config.refreshUrl,
      isPublic: true,
      queryParameters: config.refreshQueryParameters ?? {},
      data: config.refreshData ??
          {
            'grantType': 'refresh_token',
            'token': reqToken?.refreshToken,
          },
    );
    if ((result.statusCode != HttpStatus.ok &&
            result.statusCode != HttpStatus.created) ||
        result.data == null) {
      throw Exception('Refresh token failed');
    }
    return OAuth2TokenX.fromJson(result.data!);
  }

  /// Update base url
  String setBaseUrl(String baseUrl) => _dio.options.baseUrl = baseUrl;

  Future<void> setToken(OAuth2Token token) => _fresh.setToken(token);

  Future<OAuth2Token?> getToken() async => _fresh.token;

  /// Removes token
  Future<void> deleteToken() {
    return _fresh.revokeToken();
  }

  Dio get dio => _dio;
}
