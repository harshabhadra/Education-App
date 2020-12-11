// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'studentinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StudentInfo _$StudentInfoFromJson(Map<String, dynamic> json) {
  return StudentInfo(
    email: json['email'] as String,
    name: json['name'] as String,
    contactNumber: json['contactNumber'] as int,
    address: json['address'] as String,
    country: json['country'] as String,
    gender: json['gender'] as String,
    dob: json['dob'] as String,
    profDetails: json['profDetails'] as String,
  );
}

Map<String, dynamic> _$StudentInfoToJson(StudentInfo instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'contactNumber': instance.contactNumber,
      'address': instance.address,
      'country': instance.country,
      'gender': instance.gender,
      'dob': instance.dob,
      'profDetails': instance.profDetails,
    };
