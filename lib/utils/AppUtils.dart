import 'package:education_app/Model/books_model.dart';
import 'package:education_app/database/DatabaseChapter.dart';

class AppUtils {
  List<DbChapter> getConvertedChapters(List<ListOfChapter> chapterList) {
    var dbChapterList = <DbChapter>{};
    for (var chapter in chapterList) {
      DbChapter dbChapter = DbChapter(
          catagory: chapter.catagory,
          chapterID: chapter.chapterID,
          pdfLink: chapter.pdfLink,
          title: chapter.title);
      dbChapterList.add(dbChapter);
    }
    return dbChapterList.toList();
  }
}
