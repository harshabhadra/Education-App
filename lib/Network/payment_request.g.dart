// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayRequest _$PayRequestFromJson(Map<String, dynamic> json) {
  return PayRequest(
    amount: json['amount'] as int,
    currency: json['currency'] as String,
    receipt: json['receipt'] as String,
  );
}

Map<String, dynamic> _$PayRequestToJson(PayRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'receipt': instance.receipt,
    };
