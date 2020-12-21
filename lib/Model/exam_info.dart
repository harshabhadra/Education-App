class ExamInfo {
  List<Exam> examList;
  Status status;

  ExamInfo({this.examList, this.status});

  ExamInfo.fromJson(Map<String, dynamic> json) {
    if (json['examList'] != null) {
      examList = new List<Exam>();
      json['examList'].forEach((v) {
        examList.add(new Exam.fromJson(v));
      });
    }
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.examList != null) {
      data['examList'] = this.examList.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

class Exam {
  int averageMarkTillNow;
  String examCatagory;
  String examDescription;
  String examDuraction;
  int examId;
  String examType;
  int highestMarkTillNow;
  String totalMark;
  String totalNumberOfQuestion;
  int totalNumberOfStudentsAttended;

  Exam(
      {this.averageMarkTillNow,
      this.examCatagory,
      this.examDescription,
      this.examDuraction,
      this.examId,
      this.examType,
      this.highestMarkTillNow,
      this.totalMark,
      this.totalNumberOfQuestion,
      this.totalNumberOfStudentsAttended});

  Exam.fromJson(Map<String, dynamic> json) {
    averageMarkTillNow = json['averageMarkTillNow'];
    examCatagory = json['examCatagory'];
    examDescription = json['examDescription'];
    examDuraction = json['examDuraction'];
    examId = json['examId'];
    examType = json['examType'];
    highestMarkTillNow = json['highestMarkTillNow'];
    totalMark = json['totalMark'];
    totalNumberOfQuestion = json['totalNumberOfQuestion'];
    totalNumberOfStudentsAttended = json['totalNumberOfStudentsAttended'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['averageMarkTillNow'] = this.averageMarkTillNow;
    data['examCatagory'] = this.examCatagory;
    data['examDescription'] = this.examDescription;
    data['examDuraction'] = this.examDuraction;
    data['examId'] = this.examId;
    data['examType'] = this.examType;
    data['highestMarkTillNow'] = this.highestMarkTillNow;
    data['totalMark'] = this.totalMark;
    data['totalNumberOfQuestion'] = this.totalNumberOfQuestion;
    data['totalNumberOfStudentsAttended'] = this.totalNumberOfStudentsAttended;
    return data;
  }
}

class Status {
  String message;
  int statusCode;

  Status({this.message, this.statusCode});

  Status.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
