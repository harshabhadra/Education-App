import 'dart:async';
import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';

class LeaderBoardBloc extends Bloc {
  final StreamController _controller = StreamController<Map<String, dynamic>>();
  Repository _repository = Repository();
  Stream<Map<String, dynamic>> get leaderBoardStream => _controller.stream;

  void getLeaderBoard(int examId) async {
    await _repository.refreshToken().whenComplete(() {
      _getLeaderBoardList(examId);
    });
  }

  void _getLeaderBoardList(int examId) async {
    Map<String, dynamic> map = new Map<String, dynamic>();
    map = await _repository.getLeaderBoard(examId);
    _controller.sink.add(map);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
