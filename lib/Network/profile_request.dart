import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'profile_request.g.dart';
@JsonSerializable()
class ProfileRequest {
  String email;
  ProfileRequest({
    this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory ProfileRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ProfileRequest(
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileRequest.fromJson(String source) => ProfileRequest.fromMap(json.decode(source));
}
