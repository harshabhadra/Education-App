class ProfileResponse {
  Status _status;
  StudentInfo _studentInfo;

  ProfileResponse({Status status, StudentInfo studentInfo}) {
    this._status = status;
    this._studentInfo = studentInfo;
  }

  Status get status => _status;
  set status(Status status) => _status = status;
  StudentInfo get studentInfo => _studentInfo;
  set studentInfo(StudentInfo studentInfo) => _studentInfo = studentInfo;

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    _status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    _studentInfo = json['studentInfo'] != null
        ? new StudentInfo.fromJson(json['studentInfo'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._status != null) {
      data['status'] = this._status.toJson();
    }
    if (this._studentInfo != null) {
      data['studentInfo'] = this._studentInfo.toJson();
    }
    return data;
  }
}

class Status {
  String _message;
  int _statusCode;

  Status({String message, int statusCode}) {
    this._message = message;
    this._statusCode = statusCode;
  }

  String get message => _message;
  set message(String message) => _message = message;
  int get statusCode => _statusCode;
  set statusCode(int statusCode) => _statusCode = statusCode;

  Status.fromJson(Map<String, dynamic> json) {
    _message = json['message'];
    _statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this._message;
    data['statusCode'] = this._statusCode;
    return data;
  }
}

class StudentInfo {
  String _address;
  int _contactNumber;
  String _country;
  String _dob;
  String _email;
  String _gender;
  String _name;
  bool _premiumUser;
  List<PurchasedBook> _purchasedBook;

  StudentInfo(
      {String address,
      int contactNumber,
      String country,
      String dob,
      String email,
      String gender,
      String name,
      bool premiumUser,
      List<PurchasedBook> purchasedBook}) {
    this._address = address;
    this._contactNumber = contactNumber;
    this._country = country;
    this._dob = dob;
    this._email = email;
    this._gender = gender;
    this._name = name;
    this._premiumUser = premiumUser;
    this._purchasedBook = purchasedBook;
  }

  String get address => _address;
  set address(String address) => _address = address;
  int get contactNumber => _contactNumber;
  set contactNumber(int contactNumber) => _contactNumber = contactNumber;
  String get country => _country;
  set country(String country) => _country = country;
  String get dob => _dob;
  set dob(String dob) => _dob = dob;
  String get email => _email;
  set email(String email) => _email = email;
  String get gender => _gender;
  set gender(String gender) => _gender = gender;
  String get name => _name;
  set name(String name) => _name = name;
  bool get premiumUser => _premiumUser;
  set premiumUser(bool premiumUser) => _premiumUser = premiumUser;
  List<PurchasedBook> get purchasedBook => _purchasedBook;
  set purchasedBook(List<PurchasedBook> purchasedBook) =>
      _purchasedBook = purchasedBook;

  StudentInfo.fromJson(Map<String, dynamic> json) {
    _address = json['address'];
    _contactNumber = json['contactNumber'];
    _country = json['country'];
    _dob = json['dob'];
    _email = json['email'];
    _gender = json['gender'];
    _name = json['name'];
    _premiumUser = json['premiumUser'];
    if (json['purchasedBook'] != null) {
      _purchasedBook = new List<PurchasedBook>();
      json['purchasedBook'].forEach((v) {
        _purchasedBook.add(new PurchasedBook.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this._address;
    data['contactNumber'] = this._contactNumber;
    data['country'] = this._country;
    data['dob'] = this._dob;
    data['email'] = this._email;
    data['gender'] = this._gender;
    data['name'] = this._name;
    data['premiumUser'] = this._premiumUser;
    if (this._purchasedBook != null) {
      data['purchasedBook'] =
          this._purchasedBook.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PurchasedBook {
  String _bookName;
  String _author;
  int _bookID;
  String _description;
  String _examType;
  List<ListOfChapter> _listOfChapter;
  String _offer;
  String _price;
  String _purchaseType;

  PurchasedBook(
      {String bookName,
      String author,
      int bookID,
      String description,
      String examType,
      List<ListOfChapter> listOfChapter,
      String offer,
      String price,
      String purchaseType}) {
    this._bookName = bookName;
    this._author = author;
    this._bookID = bookID;
    this._description = description;
    this._examType = examType;
    this._listOfChapter = listOfChapter;
    this._offer = offer;
    this._price = price;
    this._purchaseType = purchaseType;
  }

  String get bookName => _bookName;
  set bookName(String bookName) => _bookName = bookName;
  String get author => _author;
  set author(String author) => _author = author;
  int get bookID => _bookID;
  set bookID(int bookID) => _bookID = bookID;
  String get description => _description;
  set description(String description) => _description = description;
  String get examType => _examType;
  set examType(String examType) => _examType = examType;
  List<ListOfChapter> get listOfChapter => _listOfChapter;
  set listOfChapter(List<ListOfChapter> listOfChapter) =>
      _listOfChapter = listOfChapter;
  String get offer => _offer;
  set offer(String offer) => _offer = offer;
  String get price => _price;
  set price(String price) => _price = price;
  String get purchaseType => _purchaseType;
  set purchaseType(String purchaseType) => _purchaseType = purchaseType;

  PurchasedBook.fromJson(Map<String, dynamic> json) {
    _bookName = json['BookName'];
    _author = json['author'];
    _bookID = json['bookID'];
    _description = json['description'];
    _examType = json['examType'];
    if (json['listOfChapter'] != null) {
      _listOfChapter = new List<ListOfChapter>();
      json['listOfChapter'].forEach((v) {
        _listOfChapter.add(new ListOfChapter.fromJson(v));
      });
    }
    _offer = json['offer'];
    _price = json['price'];
    _purchaseType = json['purchaseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookName'] = this._bookName;
    data['author'] = this._author;
    data['bookID'] = this._bookID;
    data['description'] = this._description;
    data['examType'] = this._examType;
    if (this._listOfChapter != null) {
      data['listOfChapter'] =
          this._listOfChapter.map((v) => v.toJson()).toList();
    }
    data['offer'] = this._offer;
    data['price'] = this._price;
    data['purchaseType'] = this._purchaseType;
    return data;
  }
}

class ListOfChapter {
  String _catagory;
  int _chapterID;
  String _pdfLink;
  String _title;

  ListOfChapter(
      {String catagory, int chapterID, String pdfLink, String title}) {
    this._catagory = catagory;
    this._chapterID = chapterID;
    this._pdfLink = pdfLink;
    this._title = title;
  }

  String get catagory => _catagory;
  set catagory(String catagory) => _catagory = catagory;
  int get chapterID => _chapterID;
  set chapterID(int chapterID) => _chapterID = chapterID;
  String get pdfLink => _pdfLink;
  set pdfLink(String pdfLink) => _pdfLink = pdfLink;
  String get title => _title;
  set title(String title) => _title = title;

  ListOfChapter.fromJson(Map<String, dynamic> json) {
    _catagory = json['catagory'];
    _chapterID = json['chapterID'];
    _pdfLink = json['pdfLink'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catagory'] = this._catagory;
    data['chapterID'] = this._chapterID;
    data['pdfLink'] = this._pdfLink;
    data['title'] = this._title;
    return data;
  }
}
