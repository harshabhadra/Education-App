class SubsResponse {
  String _id;
  String _entity;
  String _planId;
  String _status;
  int _quantity;
  int _chargeAt;
  int _startAt;
  int _endAt;
  int _authAttempts;
  int _totalCount;
  int _paidCount;
  bool _customerNotify;
  int _createdAt;
  int _expireBy;
  String _shortUrl;
  String _source;
  int _remainingCount;

  SubsResponse(
      {String id,
      String entity,
      String planId,
      String status,
      int quantity,
      int chargeAt,
      int startAt,
      int endAt,
      int authAttempts,
      int totalCount,
      int paidCount,
      bool customerNotify,
      int createdAt,
      int expireBy,
      String shortUrl,
      String source,
      int remainingCount}) {
    this._id = id;
    this._entity = entity;
    this._planId = planId;
    this._status = status;
    this._quantity = quantity;
    this._chargeAt = chargeAt;
    this._startAt = startAt;
    this._endAt = endAt;
    this._authAttempts = authAttempts;
    this._totalCount = totalCount;
    this._paidCount = paidCount;
    this._customerNotify = customerNotify;
    this._createdAt = createdAt;
    this._expireBy = expireBy;
    this._shortUrl = shortUrl;
    this._source = source;
    this._remainingCount = remainingCount;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get entity => _entity;
  set entity(String entity) => _entity = entity;
  String get planId => _planId;
  set planId(String planId) => _planId = planId;
  String get status => _status;
  set status(String status) => _status = status;
  int get quantity => _quantity;
  set quantity(int quantity) => _quantity = quantity;
  int get chargeAt => _chargeAt;
  set chargeAt(int chargeAt) => _chargeAt = chargeAt;
  int get startAt => _startAt;
  set startAt(int startAt) => _startAt = startAt;
  int get endAt => _endAt;
  set endAt(int endAt) => _endAt = endAt;
  int get authAttempts => _authAttempts;
  set authAttempts(int authAttempts) => _authAttempts = authAttempts;
  int get totalCount => _totalCount;
  set totalCount(int totalCount) => _totalCount = totalCount;
  int get paidCount => _paidCount;
  set paidCount(int paidCount) => _paidCount = paidCount;
  bool get customerNotify => _customerNotify;
  set customerNotify(bool customerNotify) => _customerNotify = customerNotify;
  int get createdAt => _createdAt;
  set createdAt(int createdAt) => _createdAt = createdAt;
  int get expireBy => _expireBy;
  set expireBy(int expireBy) => _expireBy = expireBy;
  String get shortUrl => _shortUrl;
  set shortUrl(String shortUrl) => _shortUrl = shortUrl;
  String get source => _source;
  set source(String source) => _source = source;
  int get remainingCount => _remainingCount;
  set remainingCount(int remainingCount) => _remainingCount = remainingCount;

  SubsResponse.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _entity = json['entity'];
    _planId = json['plan_id'];
    _status = json['status'];
    _quantity = json['quantity'];
    _chargeAt = json['charge_at'];
    _startAt = json['start_at'];
    _endAt = json['end_at'];
    _authAttempts = json['auth_attempts'];
    _totalCount = json['total_count'];
    _paidCount = json['paid_count'];
    _customerNotify = json['customer_notify'];
    _createdAt = json['created_at'];
    _expireBy = json['expire_by'];
    _shortUrl = json['short_url'];
    _source = json['source'];
    _remainingCount = json['remaining_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['entity'] = this._entity;
    data['plan_id'] = this._planId;
    data['status'] = this._status;
    data['quantity'] = this._quantity;
    data['charge_at'] = this._chargeAt;
    data['start_at'] = this._startAt;
    data['end_at'] = this._endAt;
    data['auth_attempts'] = this._authAttempts;
    data['total_count'] = this._totalCount;
    data['paid_count'] = this._paidCount;
    data['customer_notify'] = this._customerNotify;
    data['created_at'] = this._createdAt;
    data['expire_by'] = this._expireBy;
    data['short_url'] = this._shortUrl;
    data['source'] = this._source;
    data['remaining_count'] = this._remainingCount;
    return data;
  }
}
