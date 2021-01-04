import 'dart:async';

import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';

class ExamQuestionsBloc extends Bloc {
  final _controller = StreamController<Map<String, dynamic>>();

  Stream get questionsStream => _controller.stream;

  void getQuestions(int examId) async {
    Repository repository = Repository();
    await repository.refreshToken().whenComplete(() {
      getAllQuestions(examId);
    });
  }

  void getAllQuestions(int examId) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    Repository repository = Repository();
    map = await repository.getQuestions(examId);
    _controller.sink.add(map);
  }

  @override
  void dispose() {
    _controller.close();
    // TODO: implement dispose
  }
}
