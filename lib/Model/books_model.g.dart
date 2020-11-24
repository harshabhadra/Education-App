// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Books _$BooksFromJson(Map<String, dynamic> json) {
  return Books(
    bookList: (json['bookList'] as List)
        ?.map((e) =>
            e == null ? null : BookList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$BooksToJson(Books instance) => <String, dynamic>{
      'bookList': instance.bookList,
      'status': instance.status,
    };

BookList _$BookListFromJson(Map<String, dynamic> json) {
  return BookList(
    bookName: json['bookName'] as String,
    author: json['author'] as String,
    bookID: json['bookID'] as int,
    demoBookLink: json['demoBookLink'] as String,
    description: json['description'] as String,
    listOfChapter: (json['listOfChapter'] as List)
        ?.map((e) => e == null
            ? null
            : ListOfChapter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    offer: (json['offer'] as num)?.toDouble(),
    price: (json['price'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$BookListToJson(BookList instance) => <String, dynamic>{
      'bookName': instance.bookName,
      'author': instance.author,
      'bookID': instance.bookID,
      'demoBookLink': instance.demoBookLink,
      'description': instance.description,
      'listOfChapter': instance.listOfChapter,
      'offer': instance.offer,
      'price': instance.price,
    };

ListOfChapter _$ListOfChapterFromJson(Map<String, dynamic> json) {
  return ListOfChapter(
    catagory: json['catagory'] as String,
    chapterID: json['chapterID'] as int,
    pdfLink: json['pdfLink'] as String,
    title: json['title'] as String,
  );
}

Map<String, dynamic> _$ListOfChapterToJson(ListOfChapter instance) =>
    <String, dynamic>{
      'catagory': instance.catagory,
      'chapterID': instance.chapterID,
      'pdfLink': instance.pdfLink,
      'title': instance.title,
    };

Status _$StatusFromJson(Map<String, dynamic> json) {
  return Status(
    message: json['message'] as String,
    statusCode: json['statusCode'] as int,
  );
}

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'message': instance.message,
      'statusCode': instance.statusCode,
    };
