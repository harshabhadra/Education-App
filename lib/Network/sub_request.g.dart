// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sub_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubsRequest _$SubsRequestFromJson(Map<String, dynamic> json) {
  return SubsRequest(
    planId: json['planId'] as String,
    totalCount: json['totalCount'] as int,
    quantity: json['quantity'] as int,
    customerNotify: json['customerNotify'] as int,
    startAt: json['startAt'] as int,
    expireBy: json['expireBy'] as int,
  );
}

Map<String, dynamic> _$SubsRequestToJson(SubsRequest instance) =>
    <String, dynamic>{
      'planId': instance.planId,
      'totalCount': instance.totalCount,
      'quantity': instance.quantity,
      'customerNotify': instance.customerNotify,
      'startAt': instance.startAt,
      'expireBy': instance.expireBy,
    };
