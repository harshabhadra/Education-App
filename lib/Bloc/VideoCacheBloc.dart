import 'dart:async';

import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/database/DatabaseVideo.dart';
import 'package:hive/hive.dart';

class VideoCacheBloc implements Bloc {
  final _controller = StreamController<List<DatabaseVideoList>>();

  Stream get videoListStream => _controller.stream;

  void getCacheVideos() {
    var dbVideoList = <DatabaseVideoList>{};
    var box = Hive.box('videos');
    if (box.isNotEmpty) {
      for (var i = 0; i < box.length; i++) {
        if (!dbVideoList.contains(box.getAt(i))) {
          
          dbVideoList.add(box.getAt(i));
        }
      }
      
      _controller.sink.add(dbVideoList.toList());
    }
  }

  @override
  void dispose() {
    _controller.close();
  }
}
