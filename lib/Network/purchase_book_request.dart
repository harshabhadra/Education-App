class PurchaseBookRequest {
  String _email;
  int _bookId;

  PurchaseBookRequest({String email, int bookId}) {
    this._email = email;
    this._bookId = bookId;
  }

  String get email => _email;
  set email(String email) => _email = email;
  int get bookId => _bookId;
  set bookId(int bookId) => _bookId = bookId;

  PurchaseBookRequest.fromJson(Map<String, dynamic> json) {
    _email = json['email'];
    _bookId = json['bookId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this._email;
    data['bookId'] = this._bookId;
    return data;
  }
}
