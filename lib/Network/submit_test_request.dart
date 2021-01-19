class SubmitTestRequest {
  String email;
  int examId;
  int totalMark;
  int markObtained;
  List<AnswerDetails> examDetails;

  SubmitTestRequest(
      {this.email,
      this.examId,
      this.totalMark,
      this.markObtained,
      this.examDetails});

  SubmitTestRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    examId = json['examId'];
    totalMark = json['totalMark'];
    markObtained = json['markObtained'];
    if (json['examDetails'] != null) {
      examDetails = new List<AnswerDetails>();
      json['examDetails'].forEach((v) {
        examDetails.add(new AnswerDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['examId'] = this.examId;
    data['totalMark'] = this.totalMark;
    data['markObtained'] = this.markObtained;
    if (this.examDetails != null) {
      data['examDetails'] = this.examDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerDetails {
  int questionId;
  String questionAnswer;
  String studentAnswer;

  AnswerDetails({this.questionId, this.questionAnswer, this.studentAnswer});

  AnswerDetails.fromJson(Map<String, dynamic> json) {
    questionId = json['questionId'];
    questionAnswer = json['questionAnswer'];
    studentAnswer = json['studentAnswer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['questionId'] = this.questionId;
    data['questionAnswer'] = this.questionAnswer;
    data['studentAnswer'] = this.studentAnswer;
    return data;
  }
}
