import 'dart:async';

import 'package:education_app/Bloc/Bloc.dart';
import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Network/submit_test_request.dart';

class OnlineTestBloc extends Bloc {
  final StreamController _controller = StreamController<dynamic>();

  Stream get onlineTestStream => _controller.stream;

  void submitTestReport(SubmitTestRequest submitTestRequest) async {
    Repository repository = Repository();
    await repository.refreshToken().whenComplete(() {
      _sendTestReport(submitTestRequest);
    });
  }

  void _sendTestReport(SubmitTestRequest submitTestRequest) async {
    Repository repository = Repository();
    Map<String, dynamic> map = new Map<String, dynamic>();
    map = await repository.sendTestReport(submitTestRequest);
    _controller.sink.add(map);
  }

  @override
  void dispose() {
    _controller.close();
  }
}
