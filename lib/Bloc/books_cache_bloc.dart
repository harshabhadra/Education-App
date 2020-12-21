import 'dart:async';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';

import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/utils/AppUtils.dart';

class BooksCacheBloc implements Bloc {
  final controller = StreamController<List<DatabaseBook>>();

  Stream<List<DatabaseBook>> get booksStream => controller.stream;

  void getBooks() async {
    var dbBookList = <DatabaseBook>{};
    var box = Hive.box('books');
    if (box.isNotEmpty) {
      print('Book box lenght: ${box.length}');
      for (int i = 0; i < box.length; i++) {
        dbBookList.add(box.getAt(i));
      }
      print('dbBooklist lenght: ${dbBookList.length}');
      controller.sink.add(dbBookList.toList());
    } else {
      print('book box is empty');
      Dio dio = Dio();
      ApiClient apiClient = ApiClient(dio);
      try {
        var response = await apiClient.getBooks();
        print('Book  request response: ' + response.toJson().toString());
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

          if (!dbBookList.contains(dbBook)) {
            dbBookList.add(dbBook);
            box.add(dbBook);
          }
        }
        controller.sink.add(dbBookList.toList());
      } catch (error) {
        print("Error fetching books: $error");
      }
    }
    // controller.sink.add(dbBookList.toList());
  }

  @override
  void dispose() {
    controller.close();
  }
}
