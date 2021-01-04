// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenResponse _$RefreshTokenResponseFromJson(Map<String, dynamic> json) {
  return RefreshTokenResponse(
    customToken: json['customToken'] as String,
    message: json['message'] as String,
    refreshToken: json['refreshToken'] as String,
    statusCode: json['statusCode'] as int,
  );
}

Map<String, dynamic> _$RefreshTokenResponseToJson(
        RefreshTokenResponse instance) =>
    <String, dynamic>{
      'customToken': instance.customToken,
      'message': instance.message,
      'refreshToken': instance.refreshToken,
      'statusCode': instance.statusCode,
    };
