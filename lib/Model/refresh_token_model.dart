
import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_model.g.dart';
@JsonSerializable()
class RefreshTokenResponse {
  String _customToken;
  String _message;
  String _refreshToken;
  int _statusCode;

  RefreshTokenResponse(
      {String customToken,
      String message,
      String refreshToken,
      int statusCode}) {
    this._customToken = customToken;
    this._message = message;
    this._refreshToken = refreshToken;
    this._statusCode = statusCode;
  }

  String get customToken => _customToken;
  set customToken(String customToken) => _customToken = customToken;
  String get message => _message;
  set message(String message) => _message = message;
  String get refreshToken => _refreshToken;
  set refreshToken(String refreshToken) => _refreshToken = refreshToken;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;

  RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    _customToken = json['customToken'];
    _message = json['message'];
    _refreshToken = json['refreshToken'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customToken'] = this._customToken;
    data['message'] = this._message;
    data['refreshToken'] = this._refreshToken;
    data['statusCode'] = this._statusCode;
    return data;
  }
}
