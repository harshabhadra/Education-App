// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DatabaseVideo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseVideoListAdapter extends TypeAdapter<DatabaseVideoList> {
  @override
  final int typeId = 0;

  @override
  DatabaseVideoList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseVideoList(
      catagory: fields[0] as String,
      title: fields[1] as String,
      url: fields[2] as String,
      videoCode: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DatabaseVideoList obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.catagory)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.videoCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseVideoListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
