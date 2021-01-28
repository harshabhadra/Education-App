import 'package:education_app/Network/submit_test_request.dart';

class ExamQuestions {
  SubmitTestRequest _examAttened;
  List<QuestioListExamWise> _questioListExamWise;
  Status _status;

  ExamQuestions(
      {SubmitTestRequest examAttened,
      List<QuestioListExamWise> questioListExamWise,
      Status status}) {
    this._examAttened = examAttened;
    this._questioListExamWise = questioListExamWise;
    this._status = status;
  }

  SubmitTestRequest get examAttened => _examAttened;
  set examAttened(SubmitTestRequest examAttened) => _examAttened = examAttened;
  List<QuestioListExamWise> get questioListExamWise => _questioListExamWise;
  set questioListExamWise(List<QuestioListExamWise> questioListExamWise) =>
      _questioListExamWise = questioListExamWise;
  Status get status => _status;
  set status(Status status) => _status = status;

  ExamQuestions.fromJson(Map<String, dynamic> json) {
    _examAttened = json['examAttened'] != null
        ? new SubmitTestRequest.fromJson(json['examAttened'])
        : null;
    if (json['questioListExamWise'] != null) {
      _questioListExamWise = new List<QuestioListExamWise>();
      json['questioListExamWise'].forEach((v) {
        _questioListExamWise.add(new QuestioListExamWise.fromJson(v));
      });
    }
    _status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._examAttened != null) {
      data['examAttened'] = this._examAttened.toJson();
    }
    if (this._questioListExamWise != null) {
      data['questioListExamWise'] =
          this._questioListExamWise.map((v) => v.toJson()).toList();
    }
    if (this._status != null) {
      data['status'] = this._status.toJson();
    }
    return data;
  }
}

class ExamAttened {
  String _email;
  List<ExamDetails> _examDetails;
  int _examId;
  int _markObtained;
  int _totalMark;

  ExamAttened(
      {String email,
      List<ExamDetails> examDetails,
      int examId,
      int markObtained,
      int totalMark}) {
    this._email = email;
    this._examDetails = examDetails;
    this._examId = examId;
    this._markObtained = markObtained;
    this._totalMark = totalMark;
  }

  String get email => _email;
  set email(String email) => _email = email;
  List<ExamDetails> get examDetails => _examDetails;
  set examDetails(List<ExamDetails> examDetails) => _examDetails = examDetails;
  int get examId => _examId;
  set examId(int examId) => _examId = examId;
  int get markObtained => _markObtained;
  set markObtained(int markObtained) => _markObtained = markObtained;
  int get totalMark => _totalMark;
  set totalMark(int totalMark) => _totalMark = totalMark;

  ExamAttened.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    if (json['examDetails'] != null) {
      _examDetails = new List<ExamDetails>();
      json['examDetails'].forEach((v) {
        _examDetails.add(new ExamDetails.fromJson(v));
      });
    }
    _examId = json['examId'];
    _markObtained = json['markObtained'];
    _totalMark = json['totalMark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    if (this._examDetails != null) {
      data['examDetails'] = this._examDetails.map((v) => v.toJson()).toList();
    }
    data['examId'] = this._examId;
    data['markObtained'] = this._markObtained;
    data['totalMark'] = this._totalMark;
    return data;
  }
}

class ExamDetails {
  String _questionAnswer;
  int _questionId;
  String _studentAnswer;

  ExamDetails({String questionAnswer, int questionId, String studentAnswer}) {
    this._questionAnswer = questionAnswer;
    this._questionId = questionId;
    this._studentAnswer = studentAnswer;
  }

  String get questionAnswer => _questionAnswer;
  set questionAnswer(String questionAnswer) => _questionAnswer = questionAnswer;
  int get questionId => _questionId;
  set questionId(int questionId) => _questionId = questionId;
  String get studentAnswer => _studentAnswer;
  set studentAnswer(String studentAnswer) => _studentAnswer = studentAnswer;

  ExamDetails.fromJson(Map<String, dynamic> json) {
    _questionAnswer = json['questionAnswer'];
    _questionId = json['questionId'];
    _studentAnswer = json['studentAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionAnswer'] = this._questionAnswer;
    data['questionId'] = this._questionId;
    data['studentAnswer'] = this._studentAnswer;
    return data;
  }
}

class QuestioListExamWise {
  int _examId;
  String _questionAnswer;
  String _questionDescription;
  int _questionId;
  String _questionImage;
  int _questionMark;
  List<String> _questionOptions;

  QuestioListExamWise(
      {int examId,
      String questionAnswer,
      String questionDescription,
      int questionId,
      String questionImage,
      int questionMark,
      List<String> questionOptions}) {
    this._examId = examId;
    this._questionAnswer = questionAnswer;
    this._questionDescription = questionDescription;
    this._questionId = questionId;
    this._questionImage = questionImage;
    this._questionMark = questionMark;
    this._questionOptions = questionOptions;
  }

  int get examId => _examId;
  set examId(int examId) => _examId = examId;
  String get questionAnswer => _questionAnswer;
  set questionAnswer(String questionAnswer) => _questionAnswer = questionAnswer;
  String get questionDescription => _questionDescription;
  set questionDescription(String questionDescription) =>
      _questionDescription = questionDescription;
  int get questionId => _questionId;
  set questionId(int questionId) => _questionId = questionId;
  String get questionImage => _questionImage;
  set questionImage(String questionImage) => _questionImage = questionImage;
  int get questionMark => _questionMark;
  set questionMark(int questionMark) => _questionMark = questionMark;
  List<String> get questionOptions => _questionOptions;
  set questionOptions(List<String> questionOptions) =>
      _questionOptions = questionOptions;

  QuestioListExamWise.fromJson(Map<String, dynamic> json) {
    _examId = json['examId'];
    _questionAnswer = json['questionAnswer'];
    _questionDescription = json['questionDescription'];
    _questionId = json['questionId'];
    _questionImage = json['questionImage'];
    _questionMark = json['questionMark'];
    _questionOptions = json['questionOptions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examId'] = this._examId;
    data['questionAnswer'] = this._questionAnswer;
    data['questionDescription'] = this._questionDescription;
    data['questionId'] = this._questionId;
    data['questionImage'] = this._questionImage;
    data['questionMark'] = this._questionMark;
    data['questionOptions'] = this._questionOptions;
    return data;
  }
}

class Status {
  String _message;
  int _statusCode;

  Status({String message, int statusCode}) {
    this._message = message;
    this._statusCode = statusCode;
  }

  String get message => _message;
  set message(String message) => _message = message;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;

  Status.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['statusCode'] = this._statusCode;
    return data;
  }
}
