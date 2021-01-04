import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/Video.dart';
import 'package:dio/dio.dart';
import 'package:education_app/Network/ApiClient.dart';
import 'package:education_app/database/DatabaseVideo.dart';
import 'package:hive/hive.dart';

class VideoListBloc implements Bloc {
  final _controller = StreamController<List<String>>();

  Stream<List<String>> get videosStream => _controller.stream;

  void getVideos(Dio dio) async {
    Repository repository = Repository();

    await repository.refreshToken().whenComplete(() => getAllVideos(dio));
  }

  void getAllVideos(Dio dio) async {
    var box = Hive.box('category');
    var videoBox = Hive.box('videos');

    var catList = List<String>();
    var dbVideoList = <DatabaseVideoList>{};

    if (videoBox.isNotEmpty) {
      for (var i = 0; i < videoBox.length; i++) {
        dbVideoList.add(videoBox.getAt(i));
      }
    }

    if (box.isNotEmpty) {
      var list = box.get('cat');
      print('no. of categories: ' + box.length.toString());
      catList.addAll(list);
      _controller.sink.add(catList);
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
        box.put('cat', catList);
        _controller.sink.add(catList);
      } else {
        box.clear();
        box.delete('cat');
        box.put('cat', catList);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
