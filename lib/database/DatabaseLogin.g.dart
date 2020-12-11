// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DatabaseLogin.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseLoginAdapter extends TypeAdapter<DatabaseLogin> {
  @override
  final int typeId = 3;

  @override
  DatabaseLogin read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseLogin(
      email: fields[0] as String,
      password: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DatabaseLogin obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.email)
      ..writeByte(1)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseLoginAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
