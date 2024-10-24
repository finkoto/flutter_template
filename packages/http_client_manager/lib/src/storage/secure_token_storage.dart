import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_dio/fresh_dio.dart';

class SecureTokenStorage implements TokenStorage<OAuth2Token> {
  static const String _accessToken = 'access_token';

  late final FlutterSecureStorage _secureStorage;

  Future<void> initialize() async {
    _secureStorage = const FlutterSecureStorage();
  }

  @override
  Future<void> delete() async {
    await _secureStorage.delete(key: _accessToken);
  }

  @override
  Future<OAuth2Token?> read() async {
    final tokenString = await _secureStorage.read(key: _accessToken);
    if (tokenString == null) {
      return Future.value();
    }
    return _jsonToToken(jsonDecode(tokenString) as Map<String, dynamic>);
  }

  @override
  Future<void> write(OAuth2Token token) async {
    await _secureStorage.write(key: _accessToken, value: _tokenToJson(token));
  }

  /// serialize json to [OAuth2Token]
  OAuth2Token? _jsonToToken(Map<String, dynamic>? json) {
    if (json == null) return null;
    return OAuth2Token(
      scope: 'access',
      tokenType: 'Bearer',
      accessToken: json['access'] as String,
      refreshToken: json['refresh'] != null ? json['refresh'] as String : null,
    );
  }

  String _tokenToJson(OAuth2Token token) {
    final data = <String, dynamic>{};
    data['access'] = token.accessToken;
    data['refresh'] = token.refreshToken;
    data['scope'] = token.scope;
    return jsonEncode(data);
  }
}

SecureTokenStorage secureStorage = SecureTokenStorage();
