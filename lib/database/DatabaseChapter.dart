import 'package:hive/hive.dart';
part 'DatabaseChapter.g.dart';

@HiveType(typeId: 2)
class DbChapter {
  @HiveField(0)
  String catagory;
  @HiveField(1)
  int chapterID;
  @HiveField(2)
  String pdfLink;
  @HiveField(3)
  String title;
  DbChapter({
    this.catagory,
    this.chapterID,
    this.pdfLink,
    this.title,
  });
}