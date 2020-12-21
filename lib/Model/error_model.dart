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
}
