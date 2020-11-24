// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DatabaseChapter.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DbChapterAdapter extends TypeAdapter<DbChapter> {
  @override
  final int typeId = 2;

  @override
  DbChapter read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DbChapter(
      catagory: fields[0] as String,
      chapterID: fields[1] as int,
      pdfLink: fields[2] as String,
      title: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DbChapter obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.catagory)
      ..writeByte(1)
      ..write(obj.chapterID)
      ..writeByte(2)
      ..write(obj.pdfLink)
      ..writeByte(3)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DbChapterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
