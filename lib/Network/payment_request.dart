
import 'package:json_annotation/json_annotation.dart';
part 'payment_request.g.dart';
@JsonSerializable()
class PayRequest {
  int amount;
  String currency;
  

  PayRequest({this.amount, this.currency});

  PayRequest.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    currency = json['currency'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['currency'] = this.currency;
    return data;
  }
}
