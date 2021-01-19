import 'package:json_annotation/json_annotation.dart';
part 'Video.g.dart';

@JsonSerializable()
class Videos {
  Status status;
  List<VideoList> videoList;

  Videos({this.status, this.videoList});

  Videos.fromJson(Map<String, dynamic> json) {
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['videoList'] != null) {
      videoList = new List<VideoList>();
      json['videoList'].forEach((v) {
        videoList.add(new VideoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.status != null) {
      data['status'] = this.status.toJson();
    }
    if (this.videoList != null) {
      data['videoList'] = this.videoList.map((v) => v.toJson()).toList();
    }
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

@JsonSerializable()
class VideoList {
  String catagory;
  String title;
  String url;
  int videoCode;
  String purchaseType;

  VideoList(
      {this.catagory, this.title, this.url, this.videoCode, this.purchaseType});

  VideoList.fromJson(Map<String, dynamic> json) {
    catagory = json['catagory'];
    title = json['title'];
    url = json['url'];
    videoCode = json['videoCode'];
    purchaseType = json['purchaseType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['catagory'] = this.catagory;
    data['title'] = this.title;
    data['url'] = this.url;
    data['videoCode'] = this.videoCode;
    data['purchaseType'] = this.purchaseType;
    return data;
  }
}
