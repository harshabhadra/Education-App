import 'dart:convert';

import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/error_type.dart';
import 'package:education_app/Model/exam_questions_model.dart';
import 'package:education_app/Model/refresh_token_model.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/questions_request.dart';
import 'package:education_app/Network/refresh_token_request.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/utils/AppUtils.dart';
import 'package:hive/hive.dart';

class Repository {
  void refreshBooks() async {
    await refreshToken().whenComplete(() => getUpdatedBooks());
  }

  //get books from network
  void getUpdatedBooks() async {
    var box = Hive.box('books');
    var dbBookList = <DatabaseBook>{};

    if (box.isNotEmpty) {
      print('repo box lenght: ${box.length}');
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
        print("Error fetching books: $error");
      }
    }
  }

  Future<void> refreshToken() async {
    var box = Hive.box('cred');
    String refreshToken = box.get('refreshToken');

    RefreshTokenRequest refreshTokenRequest =
        RefreshTokenRequest(refreshToken: refreshToken);

    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);

    try {
      var response = await apiClient.refreshToken(refreshTokenRequest.toJson());
      print("Refresh Token response: " + response.response.data);
      Map<String, dynamic> map = json.decode(response.response.data);
      if (map.containsKey('customToken')) {
        RefreshTokenResponse refreshTokenResponse =
            RefreshTokenResponse.fromJson(map);
        box.delete('token');
        box.delete('refreshToken');
        box.put('token', refreshTokenResponse.customToken);
        box.put('refreshToken', refreshTokenResponse.refreshToken);
      }
    } catch (error) {
      print("Refresh token error: " + error.toString());
    }
  }

  Future<Map<String, dynamic>> getQuestions(int examId) async {
    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);
    Map<String, dynamic> map = new Map<String, dynamic>();

    QuestionsRequest _questionRequest = QuestionsRequest(examId: examId);
    try {
      var response =
          await apiClient.getQuestions(_questionRequest);
      print('Get questions response: ' + response.response.data.toString());
      Map<String, dynamic> responseMap = json.decode(response.response.data);
      if (responseMap.containsKey('questioListExamWise')) {
        ExamQuestions examQuestions = ExamQuestions.fromJson(responseMap);
        map['questions'] = examQuestions;
        map['error'] = null;
      } else {
        ErrorModel errorModel = ErrorModel(
            title: "Unknown",
            description: "Unknown",
            errorType: ErrorType.Unknown);
        map['questions'] = null;
        map['error'] = errorModel;
      }
    } catch (error) {
      print('Error getting questions: ' + error.toString());
    }
    return map;
  }
}
