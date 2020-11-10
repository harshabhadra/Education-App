import 'package:json_annotation/json_annotation.dart';
part 'SignUpResponse.g.dart';

@JsonSerializable()
class SignUpResponse {
  String message;
  int statusCode;

  SignUpResponse({this.message, this.statusCode});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
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
