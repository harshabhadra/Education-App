import 'package:json_annotation/json_annotation.dart';
part 'LoginResponse.g.dart';

@JsonSerializable()
class LoginResponse {
  bool _detailPresent;
  String _message;
  int _statusCode;
  String _customToken;

  LoginResponse(
      {bool detailPresent,
      String message,
      int statusCode,
      String customToken}) {
    this._detailPresent = detailPresent;
    this._message = message;
    this._statusCode = statusCode;
    this._customToken = customToken;
  }

  bool get detailPresent => _detailPresent;
  set detailPresent(bool detailPresent) => _detailPresent = detailPresent;
  String get message => _message;
  set message(String message) => _message = message;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;
  String get customToken => _customToken;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    _detailPresent = json['detailPresent'];
    _message = json['message'];
    _statusCode = json['statusCode'];
    _customToken = json['customToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['detailPresent'] = this._detailPresent;
    data['message'] = this._message;
    data['statusCode'] = this._statusCode;
    data['customToken'] = this._customToken;
    return data;
  }
}
