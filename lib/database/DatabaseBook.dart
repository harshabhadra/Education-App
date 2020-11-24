import 'package:hive/hive.dart';
import 'DatabaseChapter.dart';
part 'DatabaseBook.g.dart';

@HiveType(typeId: 1)
class DatabaseBook {
  @HiveField(0)
  String bookName;
  @HiveField(1)
  String author;
  @HiveField(2)
  int bookID;
  @HiveField(3)
  String demoBookLink;
  @HiveField(4)
  String description;
  @HiveField(5)
  List<DbChapter> listOfChapter;
  @HiveField(6)
  double offer;
  @HiveField(7)
  double price;
  DatabaseBook({
    this.bookName,
    this.author,
    this.bookID,
    this.demoBookLink,
    this.description,
    this.listOfChapter,
    this.offer,
    this.price,
  });
}


