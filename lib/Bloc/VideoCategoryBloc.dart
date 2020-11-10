import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:hive/hive.dart';

class VideoCategoryBloc implements Bloc {
  final _controller = StreamController<List<String>>();

  Stream get categoryListStream => _controller.stream;

  void getCategories() {
    var box = Hive.box('category');
    var list = box.get('cat');
    _controller.sink.add(list);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
