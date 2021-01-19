import 'dart:async';
import 'package:dio/dio.dart';
import 'package:education_app/Network/video_request.dart';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/utils/AppUtils.dart';

class BooksCacheBloc implements Bloc {
  final controller = StreamController<List<DatabaseBook>>();

  Stream<List<DatabaseBook>> get booksStream => controller.stream;

  void getBooks(String examType) async {
    var dbBookList = <DatabaseBook>{};
      Dio dio = Dio();
      ApiClient apiClient = ApiClient(dio);
      ItemRequest _bookRequest = ItemRequest(examType: examType);
      try {
        var response = await apiClient.getBooks(_bookRequest.toJson());
        print('Book  request response: ' + response.toJson().toString());
        var books = response.bookList;
        for (var book in books) {
          var dbBook = DatabaseBook(
              bookName: book.bookName,
              author: book.author,
              bookID: book.bookID,
              description: book.description,
              listOfChapter:
                  AppUtils().getConvertedChapters(book.listOfChapter),
              offer: book.offer,
              price: book.price,
              purchaseType: book.purchaseType);

            dbBookList.add(dbBook);

        }
        controller.sink.add(dbBookList.toList());
      } catch (error) {
        print("Error fetching books: $error");
      }
  }

  List<DatabaseBook> getBooksByType(
      String purchaseType, List<DatabaseBook> bookList) {
    List<DatabaseBook> _list = List();
    _list = bookList
        .where((element) => element.purchaseType == purchaseType)
        .toList();
    return _list;
  }

  @override
  void dispose() {
    controller.close();
  }
}
