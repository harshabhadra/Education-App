// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    detailPresent: json['detailPresent'] as bool,
    message: json['message'] as String,
    statusCode: json['statusCode'] as int,
    customToken: json['customToken'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'detailPresent': instance.detailPresent,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'customToken': instance.customToken,
    };
