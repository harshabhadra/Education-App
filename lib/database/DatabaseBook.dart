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
  String description;
  @HiveField(4)
  List<DbChapter> listOfChapter;
  @HiveField(5)
  String offer;
  @HiveField(6)
  String price;
  @HiveField(7)
  String purchaseType;
  DatabaseBook({
    this.bookName,
    this.author,
    this.bookID,
    this.description,
    this.listOfChapter,
    this.offer,
    this.price,
    this.purchaseType
  });
}
