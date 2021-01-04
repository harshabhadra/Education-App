import 'package:json_annotation/json_annotation.dart';
part 'books_model.g.dart';

@JsonSerializable()
class Books {
  List<BookList> bookList;
  Status status;

  Books({this.bookList, this.status});

  Books.fromJson(Map<String, dynamic> json) {
    if (json['BookList'] != null) {
      bookList = new List<BookList>();
      json['BookList'].forEach((v) {
        bookList.add(new BookList.fromJson(v));
      });
    }
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bookList != null) {
      data['BookList'] = this.bookList.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    return data;
  }
}

@JsonSerializable()
class BookList {
  String bookName;
  String author;
  int bookID;
  String demoBookLink;
  String description;
  List<ListOfChapter> listOfChapter;
  double offer;
  double price;

  BookList(
      {this.bookName,
      this.author,
      this.bookID,
      this.demoBookLink,
      this.description,
      this.listOfChapter,
      this.offer,
      this.price});

  BookList.fromJson(Map<String, dynamic> json) {
    bookName = json['BookName'];
    author = json['author'];
    bookID = json['bookID'];
    demoBookLink = json['demoBookLink'];
    description = json['description'];
    if (json['listOfChapter'] != null) {
      listOfChapter = new List<ListOfChapter>();
      json['listOfChapter'].forEach((v) {
        listOfChapter.add(new ListOfChapter.fromJson(v));
      });
    }
    offer = json['offer'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BookName'] = this.bookName;
    data['author'] = this.author;
    data['bookID'] = this.bookID;
    data['demoBookLink'] = this.demoBookLink;
    data['description'] = this.description;
    if (this.listOfChapter != null) {
      data['listOfChapter'] =
          this.listOfChapter.map((v) => v.toJson()).toList();
    }
    data['offer'] = this.offer;
    data['price'] = this.price;
    return data;
  }
}

@JsonSerializable()
class ListOfChapter {
  String catagory;
  int chapterID;
  String pdfLink;
  String title;

  ListOfChapter({this.catagory, this.chapterID, this.pdfLink, this.title});

  ListOfChapter.fromJson(Map<String, dynamic> json) {
    catagory = json['catagory'];
    chapterID = json['chapterID'];
    pdfLink = json['pdfLink'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catagory'] = this.catagory;
    data['chapterID'] = this.chapterID;
    data['pdfLink'] = this.pdfLink;
    data['title'] = this.title;
    return data;
  }
}

@JsonSerializable()
class Status {
  String message;
  int statusCode;

  Status({this.message, this.statusCode});

  Status.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['statusCode'] = this.statusCode;
    return data;
  }
}
