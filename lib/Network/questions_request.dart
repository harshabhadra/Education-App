import 'package:json_annotation/json_annotation.dart';
part 'questions_request.g.dart';
@JsonSerializable()
class QuestionsRequest {
  int _examId;

  QuestionsRequest({int examId}) {
    this._examId = examId;
  }

  int get examId => _examId;
  set examId(int examId) => _examId = examId;

  QuestionsRequest.fromJson(Map<String, dynamic> json) {
    _examId = json['examId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['examId'] = this._examId;
    return data;
  }
}
