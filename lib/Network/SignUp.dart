
import 'package:json_annotation/json_annotation.dart';
part 'SignUp.g.dart';

@JsonSerializable()
class SignUp {
  String email;
  String password;

  SignUp({this.email, this.password});

  SignUp.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
