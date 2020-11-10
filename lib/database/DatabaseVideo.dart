import 'package:hive/hive.dart';
part 'DatabaseVideo.g.dart';

@HiveType(typeId: 0)
class DatabaseVideoList {
  @HiveField(0)
  String catagory;
  @HiveField(1)
  String title;
  @HiveField(2)
  String url;
  @HiveField(3)
  int videoCode;
  DatabaseVideoList({
    this.catagory,
    this.title,
    this.url,
    this.videoCode,
  });
}
