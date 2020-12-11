// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'student_info_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentInfoResponse _$StudentInfoResponseFromJson(Map<String, dynamic> json) {
  return StudentInfoResponse(
    statusCode: json['statusCode'] as int,
    message: json['message'] as String,
  );
}

Map<String, dynamic> _$StudentInfoResponseToJson(
        StudentInfoResponse instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'message': instance.message,
    };
