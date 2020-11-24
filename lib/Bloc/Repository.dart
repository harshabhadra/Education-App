
import 'package:education_app/Network/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/utils/AppUtils.dart';
import 'package:hive/hive.dart';

class Repository {
  void refreshBooks() async {
    var box = Hive.box('books');
    var dbBookList = <DatabaseBook>{};

    if (box.isNotEmpty) {
      print('repo box lenght: ${box.length}');
      // for (int i = 0; i < box.length; i++) {
      //   dbBookList.add(box.getAt(i));
      // }
      print('repo dbBooklist size: ${dbBookList.length}');

      Dio dio = Dio();
      ApiClient apiClient = ApiClient(dio);
      try {
        var response = await apiClient.getBooks();
        var books = response.bookList;
        for (var book in books) {
          var dbBook = DatabaseBook(
              bookName: book.bookName,
              author: book.author,
              bookID: book.bookID,
              demoBookLink: book.demoBookLink,
              description: book.description,
              listOfChapter:
                  AppUtils().getConvertedChapters(book.listOfChapter),
              offer: book.offer,
              price: book.price);

          if ((box.values.contains(dbBook))) {
            box.add(dbBook);
          }
        }
        print('repo box lenght: ${box.length}');
        // print('repo dbBooklist size: ${dbBookList.length}');
      } catch (error) {
        print("Error fetching books: ${error}");
      }
    }
  }
}
