// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DatabaseBook.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DatabaseBookAdapter extends TypeAdapter<DatabaseBook> {
  @override
  final int typeId = 1;

  @override
  DatabaseBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DatabaseBook(
      bookName: fields[0] as String,
      author: fields[1] as String,
      bookID: fields[2] as int,
      demoBookLink: fields[3] as String,
      description: fields[4] as String,
      listOfChapter: (fields[5] as List)?.cast<DbChapter>(),
      offer: fields[6] as double,
      price: fields[7] as double,
    );
  }

  @override
  void write(BinaryWriter writer, DatabaseBook obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.bookName)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.bookID)
      ..writeByte(3)
      ..write(obj.demoBookLink)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(5)
      ..write(obj.listOfChapter)
      ..writeByte(6)
      ..write(obj.offer)
      ..writeByte(7)
      ..write(obj.price);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DatabaseBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
