// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PayResponse _$PayResponseFromJson(Map<String, dynamic> json) {
  return PayResponse(
    id: json['id'] as String,
    entity: json['entity'] as String,
    amount: json['amount'] as int,
    amountPaid: json['amountPaid'] as int,
    amountDue: json['amountDue'] as int,
    currency: json['currency'] as String,
    receipt: json['receipt'] as String,
    status: json['status'] as String,
    attempts: json['attempts'] as int,
    createdAt: json['createdAt'] as int,
  );
}

Map<String, dynamic> _$PayResponseToJson(PayResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'entity': instance.entity,
      'amount': instance.amount,
      'amountPaid': instance.amountPaid,
      'amountDue': instance.amountDue,
      'currency': instance.currency,
      'receipt': instance.receipt,
      'status': instance.status,
      'attempts': instance.attempts,
      'createdAt': instance.createdAt,
    };
