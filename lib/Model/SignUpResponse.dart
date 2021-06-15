import 'package:json_annotation/json_annotation.dart';
part 'SignUpResponse.g.dart';

@JsonSerializable()
class SignUpResponse {
  String message;
  int statusCode;
  // String e;
  // String p;

  SignUpResponse({this.message, this.statusCode});

  SignUpResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
    // e = json['e'];
    // p = json['p'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    // data['e'] = this.e;
    // data['p'] = this.p;
    return data;
  }
}
