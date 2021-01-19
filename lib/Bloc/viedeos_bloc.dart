import 'dart:async';

import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Model/Video.dart';
import 'package:education_app/Model/error_model.dart';

import 'Bloc.dart';

class VideosBloc extends Bloc {
  final _categoryController = StreamController<List<String>>();

  final _videoController = StreamController<dynamic>();

  Stream get videoCategoriesStream => _categoryController.stream;
  Stream get videoStream => _videoController.stream;

  void refreshAndgetVideos(String examType) async {
    Repository _repository = Repository();
    await _repository.refreshToken().whenComplete(() => _getVideos(examType));
  }

  void _getVideos(String examType) async {
    var catList = <String>{};
    Repository _repository = Repository();
    Map<String, dynamic> _map = Map();
    List<VideoList> _videosList = List<VideoList>();
    ErrorModel _errorModel;

    _map = await _repository.getVideos(examType);
    if (_map.containsKey('videos')) {
      _videosList = _map['videos'];
      _videoController.sink.add(_videosList);
      for (VideoList video in _videosList) {
        catList.add(video.catagory);
      }
      _categoryController.sink.add(catList.toList());
    } else {
      _errorModel = _map['error'];
      _videoController.sink.add(_errorModel);
    }
  }

  @override
  void dispose() {
    _categoryController.close();
    _videoController.close();
  }
}
