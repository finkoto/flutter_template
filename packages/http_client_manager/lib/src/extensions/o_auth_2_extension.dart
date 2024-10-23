import 'package:fresh_dio/fresh_dio.dart';

extension OAuth2TokenX on OAuth2Token {
  Map<String, Object?> toJson() => {
        'access_token': accessToken,
        'refresh_token': refreshToken,
        'expires_in': expiresIn,
      };

  static OAuth2Token fromJson(Map<String, dynamic> json) {
    return OAuth2Token(
      tokenType: json['token_type']! as String,
      scope: json['scope'] != null ? json['scope']! as String : 'access_token',
      expiresIn: json['expires_in']! as int,
      accessToken: json['access_token']! as String,
      refreshToken: json['refresh_token']! as String,
    );
  }
}
