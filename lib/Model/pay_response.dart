import 'package:json_annotation/json_annotation.dart';
part 'pay_response.g.dart';
@JsonSerializable()
class PayResponse {
  String id;
  String entity;
  int amount;
  int amountPaid;
  int amountDue;
  String currency;
  String receipt;
  String status;
  int attempts;
  int createdAt;

  PayResponse(
      {this.id,
      this.entity,
      this.amount,
      this.amountPaid,
      this.amountDue,
      this.currency,
      this.receipt,
      this.status,
      this.attempts,
      this.createdAt});

  PayResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    entity = json['entity'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    amountDue = json['amount_due'];
    currency = json['currency'];
    receipt = json['receipt'];
    status = json['status'];
    attempts = json['attempts'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['entity'] = this.entity;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['amount_due'] = this.amountDue;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    data['status'] = this.status;
    data['attempts'] = this.attempts;
    data['created_at'] = this.createdAt;
    return data;
  }
}
