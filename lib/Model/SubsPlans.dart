class SubsPlans {
  String _entity;
  int _count;
  List<Items> _items;

  SubsPlans({String entity, int count, List<Items> items}) {
    this._entity = entity;
    this._count = count;
    this._items = items;
  }

  String get entity => _entity;
  set entity(String entity) => _entity = entity;
  int get count => _count;
  set count(int count) => _count = count;
  List<Items> get items => _items;
  set items(List<Items> items) => _items = items;

  SubsPlans.fromJson(Map<String, dynamic> json) {
    _entity = json['entity'];
    _count = json['count'];
    if (json['items'] != null) {
      _items = new List<Items>();
      json['items'].forEach((v) {
        _items.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['entity'] = this._entity;
    data['count'] = this._count;
    if (this._items != null) {
      data['items'] = this._items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String _id;
  String _entity;
  int _interval;
  String _period;
  Item _item;
  int _createdAt;

  Items(
      {String id,
      String entity,
      int interval,
      String period,
      Item item,
      int createdAt}) {
    this._id = id;
    this._entity = entity;
    this._interval = interval;
    this._period = period;
    this._item = item;
    this._createdAt = createdAt;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get entity => _entity;
  set entity(String entity) => _entity = entity;
  int get interval => _interval;
  set interval(int interval) => _interval = interval;
  String get period => _period;
  set period(String period) => _period = period;
  Item get item => _item;
  set item(Item item) => _item = item;
  int get createdAt => _createdAt;
  set createdAt(int createdAt) => _createdAt = createdAt;

  Items.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _entity = json['entity'];
    _interval = json['interval'];
    _period = json['period'];
    _item = json['item'] != null ? new Item.fromJson(json['item']) : null;
    _createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['entity'] = this._entity;
    data['interval'] = this._interval;
    data['period'] = this._period;
    if (this._item != null) {
      data['item'] = this._item.toJson();
    }
    data['created_at'] = this._createdAt;
    return data;
  }
}

class Item {
  String _id;
  bool _active;
  String _name;
  String _description;
  int _amount;
  int _unitAmount;
  String _currency;
  String _type;
  Null _unit;
  bool _taxInclusive;
  Null _hsnCode;
  Null _sacCode;
  Null _taxRate;
  Null _taxId;
  Null _taxGroupId;
  int _createdAt;
  int _updatedAt;

  Item(
      {String id,
      bool active,
      String name,
      String description,
      int amount,
      int unitAmount,
      String currency,
      String type,
      Null unit,
      bool taxInclusive,
      Null hsnCode,
      Null sacCode,
      Null taxRate,
      Null taxId,
      Null taxGroupId,
      int createdAt,
      int updatedAt}) {
    this._id = id;
    this._active = active;
    this._name = name;
    this._description = description;
    this._amount = amount;
    this._unitAmount = unitAmount;
    this._currency = currency;
    this._type = type;
    this._unit = unit;
    this._taxInclusive = taxInclusive;
    this._hsnCode = hsnCode;
    this._sacCode = sacCode;
    this._taxRate = taxRate;
    this._taxId = taxId;
    this._taxGroupId = taxGroupId;
    this._createdAt = createdAt;
    this._updatedAt = updatedAt;
  }

  String get id => _id;
  set id(String id) => _id = id;
  bool get active => _active;
  set active(bool active) => _active = active;
  String get name => _name;
  set name(String name) => _name = name;
  String get description => _description;
  set description(String description) => _description = description;
  int get amount => _amount;
  set amount(int amount) => _amount = amount;
  int get unitAmount => _unitAmount;
  set unitAmount(int unitAmount) => _unitAmount = unitAmount;
  String get currency => _currency;
  set currency(String currency) => _currency = currency;
  String get type => _type;
  set type(String type) => _type = type;
  Null get unit => _unit;
  set unit(Null unit) => _unit = unit;
  bool get taxInclusive => _taxInclusive;
  set taxInclusive(bool taxInclusive) => _taxInclusive = taxInclusive;
  Null get hsnCode => _hsnCode;
  set hsnCode(Null hsnCode) => _hsnCode = hsnCode;
  Null get sacCode => _sacCode;
  set sacCode(Null sacCode) => _sacCode = sacCode;
  Null get taxRate => _taxRate;
  set taxRate(Null taxRate) => _taxRate = taxRate;
  Null get taxId => _taxId;
  set taxId(Null taxId) => _taxId = taxId;
  Null get taxGroupId => _taxGroupId;
  set taxGroupId(Null taxGroupId) => _taxGroupId = taxGroupId;
  int get createdAt => _createdAt;
  set createdAt(int createdAt) => _createdAt = createdAt;
  int get updatedAt => _updatedAt;
  set updatedAt(int updatedAt) => _updatedAt = updatedAt;

  Item.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _active = json['active'];
    _name = json['name'];
    _description = json['description'];
    _amount = json['amount'];
    _unitAmount = json['unit_amount'];
    _currency = json['currency'];
    _type = json['type'];
    _unit = json['unit'];
    _taxInclusive = json['tax_inclusive'];
    _hsnCode = json['hsn_code'];
    _sacCode = json['sac_code'];
    _taxRate = json['tax_rate'];
    _taxId = json['tax_id'];
    _taxGroupId = json['tax_group_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['active'] = this._active;
    data['name'] = this._name;
    data['description'] = this._description;
    data['amount'] = this._amount;
    data['unit_amount'] = this._unitAmount;
    data['currency'] = this._currency;
    data['type'] = this._type;
    data['unit'] = this._unit;
    data['tax_inclusive'] = this._taxInclusive;
    data['hsn_code'] = this._hsnCode;
    data['sac_code'] = this._sacCode;
    data['tax_rate'] = this._taxRate;
    data['tax_id'] = this._taxId;
    data['tax_group_id'] = this._taxGroupId;
    data['created_at'] = this._createdAt;
    data['updated_at'] = this._updatedAt;
    return data;
  }
}

class Notes {
  String _notesKey1;
  String _notesKey2;

  Notes({String notesKey1, String notesKey2}) {
    this._notesKey1 = notesKey1;
    this._notesKey2 = notesKey2;
  }

  String get notesKey1 => _notesKey1;
  set notesKey1(String notesKey1) => _notesKey1 = notesKey1;
  String get notesKey2 => _notesKey2;
  set notesKey2(String notesKey2) => _notesKey2 = notesKey2;

  Notes.fromJson(Map<String, dynamic> json) {
    _notesKey1 = json['notes_key_1'];
    _notesKey2 = json['notes_key_2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notes_key_1'] = this._notesKey1;
    data['notes_key_2'] = this._notesKey2;
    return data;
  }
}
