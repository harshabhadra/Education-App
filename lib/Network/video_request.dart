import 'dart:convert';

class ItemRequest {
  final String examType;
  ItemRequest({
    this.examType,
  });

  Map<String, dynamic> toMap() {
    return {
      'examType': examType,
    };
  }

  factory ItemRequest.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ItemRequest(
      examType: map['examType'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemRequest.fromJson(String source) => ItemRequest.fromMap(json.decode(source));
}
