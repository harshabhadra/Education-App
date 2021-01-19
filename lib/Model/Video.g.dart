// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Video.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Videos _$VideosFromJson(Map<String, dynamic> json) {
  return Videos(
    status: json['status'] == null
        ? null
        : Status.fromJson(json['status'] as Map<String, dynamic>),
    videoList: (json['videoList'] as List)
        ?.map((e) =>
            e == null ? null : VideoList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$VideosToJson(Videos instance) => <String, dynamic>{
      'status': instance.status,
      'videoList': instance.videoList,
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

VideoList _$VideoListFromJson(Map<String, dynamic> json) {
  return VideoList(
    catagory: json['catagory'] as String,
    title: json['title'] as String,
    url: json['url'] as String,
    videoCode: json['videoCode'] as int,
    purchaseType: json['purchaseType'] as String,
  );
}

Map<String, dynamic> _$VideoListToJson(VideoList instance) => <String, dynamic>{
      'catagory': instance.catagory,
      'title': instance.title,
      'url': instance.url,
      'videoCode': instance.videoCode,
      'purchaseType': instance.purchaseType,
    };
