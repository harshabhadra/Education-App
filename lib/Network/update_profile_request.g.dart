// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileRequest _$UpdateProfileRequestFromJson(Map<String, dynamic> json) {
  return UpdateProfileRequest(
    email: json['email'] as String,
    name: json['name'] as String,
    contactNumber: json['contactNumber'] as int,
    address: json['address'] as String,
    country: json['country'] as String,
    gender: json['gender'] as String,
    dob: json['dob'] as String,
    premiumUser: json['premiumUser'] as bool,
    subscriptionId: json['subscriptionId'] as String,
  );
}

Map<String, dynamic> _$UpdateProfileRequestToJson(
        UpdateProfileRequest instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'contactNumber': instance.contactNumber,
      'address': instance.address,
      'country': instance.country,
      'gender': instance.gender,
      'dob': instance.dob,
      'premiumUser': instance.premiumUser,
      'subscriptionId': instance.subscriptionId,
    };
