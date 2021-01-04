class ExamQuestions {
  List<QuestioListExamWise> _questioListExamWise;
  Status _status;

  ExamQuestions(
      {List<QuestioListExamWise> questioListExamWise, Status status}) {
    this._questioListExamWise = questioListExamWise;
    this._status = status;
  }

  List<QuestioListExamWise> get questioListExamWise => _questioListExamWise;
  set questioListExamWise(List<QuestioListExamWise> questioListExamWise) =>
      _questioListExamWise = questioListExamWise;
  Status get status => _status;
  set status(Status status) => _status = status;

  ExamQuestions.fromJson(Map<String, dynamic> json) {
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

class QuestioListExamWise {
  int _examId;
  String _questionAnswer;
  String _questionDescription;
  int _questionId;
  String _questionImage;
  double _questionMark;
  List<String> _questionOptions;

  QuestioListExamWise(
      {int examId,
      String questionAnswer,
      String questionDescription,
      int questionId,
      String questionImage,
      double questionMark,
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
  double get questionMark => _questionMark;
  set questionMark(double questionMark) => _questionMark = questionMark;
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
