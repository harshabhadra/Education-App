import 'package:json_annotation/json_annotation.dart';
part'student_info_response.g.dart';
@JsonSerializable()
class StudentInfoResponse {
  int statusCode;
  String message;

  StudentInfoResponse({this.statusCode, this.message});

  StudentInfoResponse.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}
