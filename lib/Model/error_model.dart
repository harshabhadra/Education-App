import 'dart:convert';

import 'package:education_app/Model/error_type.dart';

class ErrorModel {
  String title;
  String description;
  ErrorType errorType;
  ErrorModel({
    this.title,
    this.description,
    this.errorType,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
   
    };
  }

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ErrorModel(
      title: map['title'],
      description: map['description'],
     
    );
  }

  String toJson() => json.encode(toMap());

  factory ErrorModel.fromJson(String source) => ErrorModel.fromMap(json.decode(source));
}
