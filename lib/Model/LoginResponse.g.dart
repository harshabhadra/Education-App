// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LoginResponse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginResponseAdapter extends TypeAdapter<LoginResponse> {
  @override
  final int typeId = 4;

  @override
  LoginResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginResponse()
      .._detailPresent = fields[0] as bool
      .._message = fields[1] as String
      .._statusCode = fields[2] as int
      .._customToken = fields[3] as String
      .._refreshToken = fields[4] as String;
  }

  @override
  void write(BinaryWriter writer, LoginResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj._detailPresent)
      ..writeByte(1)
      ..write(obj._message)
      ..writeByte(2)
      ..write(obj._statusCode)
      ..writeByte(3)
      ..write(obj._customToken)
      ..writeByte(4)
      ..write(obj._refreshToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    detailPresent: json['detailPresent'] as bool,
    message: json['message'] as String,
    statusCode: json['statusCode'] as int,
    customToken: json['customToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'detailPresent': instance.detailPresent,
      'message': instance.message,
      'statusCode': instance.statusCode,
      'customToken': instance.customToken,
      'refreshToken': instance.refreshToken,
    };
