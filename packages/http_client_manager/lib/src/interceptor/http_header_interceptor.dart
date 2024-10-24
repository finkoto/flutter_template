import 'dart:io';

import 'package:dio/dio.dart';

/// [HttpHeaderInterceptor] is used to send default http headers during
/// network request.
class HttpHeaderInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final lang = Platform.localeName.replaceAll('_', '-');
    options.headers[HttpHeaders.acceptLanguageHeader] = lang;
    if (options.extra['isPublic'] == true) {
      options.headers.remove(HttpHeaders.authorizationHeader);
    }
    handler.next(options);
  }
}
