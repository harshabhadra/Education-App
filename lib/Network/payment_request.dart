
import 'package:json_annotation/json_annotation.dart';
part 'payment_request.g.dart';
@JsonSerializable()
class PayRequest {
  int amount;
  String currency;
  String receipt;

  PayRequest({this.amount, this.currency, this.receipt});

  PayRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
    receipt = json['receipt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    data['receipt'] = this.receipt;
    return data;
  }
}
