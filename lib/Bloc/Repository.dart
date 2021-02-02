import 'dart:convert';

import 'package:education_app/Model/SubsPlans.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/error_type.dart';
import 'package:education_app/Model/exam_questions_model.dart';
import 'package:education_app/Model/refresh_token_model.dart';
import 'package:education_app/Model/student_info_response.dart';
import 'package:education_app/Model/subs_details.dart';
import 'package:education_app/Model/subs_response.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/payment_Client.dart';
import 'package:education_app/Network/purchase_book_request.dart';
import 'package:education_app/Network/questions_request.dart';
import 'package:education_app/Network/refresh_token_request.dart';
import 'package:education_app/Network/sub_request.dart';
import 'package:education_app/Network/submit_test_request.dart';
import 'package:education_app/Network/update_profile_request.dart';
import 'package:education_app/Network/video_request.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/utils/AppUtils.dart';
import 'package:hive/hive.dart';

class Repository {
  // void refreshBooks(String examType) async {
  //   await refreshToken().whenComplete(() => getUpdatedBooks(examType));
  // }

  // //get books from network
  // void getUpdatedBooks(String examType) async {
  //   var box = Hive.box('books');
  //   var dbBookList = <DatabaseBook>{};

  //   if (box.isNotEmpty) {
  //     print('repo box lenght: ${box.length}');
  //     print('repo dbBooklist size: ${dbBookList.length}');

  //     Dio dio = Dio();
  //     ApiClient apiClient = ApiClient(dio);
  //     ItemRequest _bookRequest = ItemRequest(examType: examType);
  //     try {
  //       var response = await apiClient.getBooks(_bookRequest.toJson());
  //       var books = response.bookList;
  //       for (var book in books) {
  //         var dbBook = DatabaseBook(
  //             bookName: book.bookName,
  //             author: book.author,
  //             bookID: book.bookID,
  //             description: book.description,
  //             listOfChapter:
  //                 AppUtils().getConvertedChapters(book.listOfChapter),
  //             offer: book.offer,
  //             price: book.price,
  //             purchaseType: book.purchaseType);

  //         if ((box.values.contains(dbBook))) {
  //           box.add(dbBook);
  //         }
  //       }
  //       print('repo box lenght: ${box.length}');
  //       // print('repo dbBooklist size: ${dbBookList.length}');
  //     } catch (error) {
  //       print("Error fetching books: $error");
  //     }
  //   }
  // }

  Future<void> refreshToken() async {
    var box = Hive.box('cred');
    String refreshToken = box.get('refreshToken');

    RefreshTokenRequest refreshTokenRequest =
        RefreshTokenRequest(refreshToken: refreshToken);

    Dio dio = Dio();
    ApiClient apiClient = ApiClient(dio);

    try {
      var response = await apiClient.refreshToken(refreshTokenRequest.toJson());

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
      var response = await apiClient.getQuestions(_questionRequest);
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

  // Get Videos
  Future<Map<String, dynamic>> getVideos(String examType) async {
    Dio dio = Dio();
    ApiClient _apiClient = ApiClient(dio);
    ItemRequest _videoRequest = ItemRequest(examType: examType);
    Map<String, dynamic> map = new Map<String, dynamic>();

    try {
      var response = await _apiClient.getVideos(_videoRequest.toJson());
      print('videos response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      if (body.containsKey('videoList')) {
        Videos videos = Videos.fromJson(body);
        var _videosList = videos.videoList;
        map['videos'] = _videosList;
      } else {
        ErrorModel errorModel = ErrorModel(
            title: 'Error',
            description: 'Unknown Error',
            errorType: ErrorType.APIError);
        map['error'] = errorModel;
      }
    } catch (error) {
      print('Video getting error: ${error.toString()}');
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
    }

    return map;
  }

  //Send test results
  Future<Map<String, dynamic>> sendTestReport(
      SubmitTestRequest submitTestRequest) async {
    Dio dio = Dio();
    ApiClient _apiClient = ApiClient(dio);
    Map<String, dynamic> map = new Map<String, dynamic>();

    try {
      var response = await _apiClient.submitTestResults(submitTestRequest);
      print('Submit test response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      return body;
    } catch (error) {
      print("error submitting test results: $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
      return map;
    }
  }

  //Get leaderboard details
  Future<Map<String, dynamic>> getLeaderBoard(int examId) async {
    Dio dio = Dio();
    ApiClient _apiClient = ApiClient(dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    QuestionsRequest _questionRequest = QuestionsRequest(examId: examId);
    try {
      var response = await _apiClient.getLeaderBoard(_questionRequest);
      print('Leaderboard response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      return body;
    } catch (error) {
      print("error submitting test results: $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
      return map;
    }
  }

  Future<Map<String, dynamic>> addPurchase(
      PurchaseBookRequest purchaseBookRequest) async {
    Dio dio = Dio();
    ApiClient _apiClient = ApiClient(dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    try {
      var response = await _apiClient.addPurchase(purchaseBookRequest);
      print('Purchase response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      return body;
    } catch (error) {
      print("error submitting purchase: $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
      return map;
    }
  }

  Future<Map<String, dynamic>> getPlans() async {
    Dio _dio = Dio();
    PaymentClient _payClient = PaymentClient(_dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    try {
      var response = await _payClient.getPlans();
      print('plans response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      SubsPlans plans = SubsPlans.fromJson(body);
      map['plans'] = plans;
    } catch (error) {
      print("error getting plans : $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
    }
    return map;
  }

  Future<Map<String, dynamic>> createSubscription(
      SubsRequest subsRequest) async {
    Dio _dio = Dio();
    PaymentClient _payClient = PaymentClient(_dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    try {
      var response = await _payClient.createSubscription(subsRequest);
      print('create subs response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      SubsResponse subsResponse = SubsResponse.fromJson(body);
      map['subs'] = subsResponse;
    } catch (error) {
      print("error creating subs : $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
    }
    return map;
  }

  Future<Map<String, dynamic>> getSubcription(String subId) async {
    Dio _dio = Dio();
    PaymentClient _payClient = PaymentClient(_dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    try {
      var response = await _payClient.getSubciption(subId);
      print('create subs response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      SubsDetails subsDetails = SubsDetails.fromJson(body);
      map['subd'] = subsDetails;
    } catch (error) {
      print("error getting subs : $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
    }
    return map;
  }

  Future<Map<String, dynamic>> updateProfile(
      UpdateProfileRequest updateProfileRequest) async {
    Dio dio = Dio();
    ApiClient _apiClient = ApiClient(dio);
    Map<String, dynamic> map = new Map<String, dynamic>();
    try {
      var response = await _apiClient.updateStudentInfo(updateProfileRequest);
      print('update profile response: ${response.response.data.toString()}');
      Map<String, dynamic> body =
          json.decode(response.response.data.toString());
      StudentInfoResponse studentInfoResponse =
          StudentInfoResponse.fromJson(body);
      map['stdInfo'] = studentInfoResponse;
      return map;
    } catch (error) {
      print("error updating profile: $error");
      ErrorModel errorModel = ErrorModel(
          title: 'Error',
          description: error.toString(),
          errorType: ErrorType.APIError);
      map['error'] = errorModel;
      return map;
    }
  }
}
