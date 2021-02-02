import 'package:json_annotation/json_annotation.dart';
part 'sub_request.g.dart';
@JsonSerializable()
class SubsRequest {
  String _planId;
  int _totalCount;
  int _quantity;
  int _customerNotify;
  int _startAt;
  int _expireBy;

  SubsRequest(
      {String planId,
      int totalCount,
      int quantity,
      int customerNotify,
      int startAt,
      int expireBy}) {
    this._planId = planId;
    this._totalCount = totalCount;
    this._quantity = quantity;
    this._customerNotify = customerNotify;
    this._startAt = startAt;
    this._expireBy = expireBy;
  }

  String get planId => _planId;
  set planId(String planId) => _planId = planId;
  int get totalCount => _totalCount;
  set totalCount(int totalCount) => _totalCount = totalCount;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;
  int get customerNotify => _customerNotify;
  set customerNotify(int customerNotify) => _customerNotify = customerNotify;
  int get startAt => _startAt;
  set startAt(int startAt) => _startAt = startAt;
  int get expireBy => _expireBy;
  set expireBy(int expireBy) => _expireBy = expireBy;

  SubsRequest.fromJson(Map<String, dynamic> json) {
    _planId = json['plan_id'];
    _totalCount = json['total_count'];
    _quantity = json['quantity'];
    _customerNotify = json['customer_notify'];
    _startAt = json['start_at'];
    _expireBy = json['expire_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['plan_id'] = this._planId;
    data['total_count'] = this._totalCount;
    data['quantity'] = this._quantity;
    data['customer_notify'] = this._customerNotify;
    data['start_at'] = this._startAt;
    data['expire_by'] = this._expireBy;
    return data;
  }
}
