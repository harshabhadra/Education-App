import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Model/Video.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/database/DatabaseVideo.dart';
import 'package:hive/hive.dart';

class VideoListBloc implements Bloc {
  final _controller = StreamController<List<VideoList>>();

  Stream<List<VideoList>> get videosStream => _controller.stream;

  void getVideos(Dio dio) async {
    var box = Hive.box('category');
    var videoBox = Hive.box('videos');

    var catList = <String>{};
    var pCatList = <String>{};
    var dbVideoList = <DatabaseVideoList>{};

    if (videoBox.isNotEmpty) {
      for (var i = 0; i < box.length; i++) {
        dbVideoList.add(box.getAt(i));
      }
    }

    if (box.isNotEmpty) {
      catList = box.get('cat');
    }

    ApiClient apiClient = ApiClient(dio);
    Videos response;
    try {
      response = await apiClient.getVideos();
      var videoList = response.videoList;

      for (var video in videoList) {
        if (!catList.contains(video.catagory)) {
          catList.add(video.catagory);
        }

        var databseVideo = DatabaseVideoList(
            catagory: video.catagory,
            title: video.title,
            url: video.url,
            videoCode: video.videoCode);

        if (!dbVideoList.contains(databseVideo)) {
          videoBox.add(databseVideo);
        }
      }

      if (box.isEmpty) {
        box.put('cat', catList.toList());
      } else {
        box.clear();
        box.delete('cat');
        box.put('cat', catList.toList());
      }
      _controller.sink.add(videoList);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
