import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'refresh_token_request.g.dart';
@JsonSerializable()
class RefreshTokenRequest {
  String refreshToken;
  RefreshTokenRequest({
    this.refreshToken,
  });
  

  Map<String, dynamic> toMap() {
    return {
      'refreshToken': refreshToken,
    };
  }

  factory RefreshTokenRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return RefreshTokenRequest(
      refreshToken: map['refreshToken'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RefreshTokenRequest.fromJson(String source) => RefreshTokenRequest.fromMap(json.decode(source));
}
