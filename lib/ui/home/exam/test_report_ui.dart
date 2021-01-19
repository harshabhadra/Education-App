import 'package:education_app/Bloc/online_test_bloc.dart';
import 'package:education_app/Model/exam_questions_model.dart';
import 'package:education_app/Network/submit_test_request.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TestReportScreen extends StatefulWidget {
  final SubmitTestRequest submitTestRequest;
  final List<QuestioListExamWise> questionsList;
  TestReportScreen(
      {Key key, @required this.submitTestRequest, @required this.questionsList})
      : super(key: key);

  @override
  _TestReportScreenState createState() => _TestReportScreenState();
}

class _TestReportScreenState extends State<TestReportScreen> {
  OnlineTestBloc bloc;
  List<AnswerDetails> answersList;

  @override
  void initState() {
    answersList = widget.submitTestRequest.examDetails;
    print('Questions list size: ${widget.questionsList.length}');
    print('Answers List size: ${answersList.length}');
    bloc = OnlineTestBloc();
    bloc.submitTestReport(widget.submitTestRequest);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        backgroundColor: kPrimaryColor,
        child: Icon(Icons.leaderboard_outlined),
      ),
      body: SafeArea(
        child: StreamBuilder(
            stream: bloc.onlineTestStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return _buildReportPage();
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Widget _buildReportPage() {
    return Container(
      color: Colors.blue[100],
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: SvgPicture.asset('assets/images/result.svg'))),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Test',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                      Text('Report',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Total Marks: ${widget.submitTestRequest.totalMark}',
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.w600),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.0),
                        child: Text(
                          'Your Score: ${widget.submitTestRequest.markObtained}',
                          style: TextStyle(
                              fontSize: 24.0, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 8, 16),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.questionsList.length,
                            itemBuilder: (context, index) {
                              QuestioListExamWise question =
                                  widget.questionsList[index];
                              AnswerDetails answerDetails = answersList[index];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(bottom: 8.0),
                                      child: Text(
                                        'Q. ${question.questionDescription}',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 4.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Correct Answer: ',
                                          style: TextStyle(fontSize: 16.0),
                                        ),
                                        Text(
                                          '${answerDetails.questionAnswer}',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    
                                    color: (answerDetails.questionAnswer ==
                                            answerDetails.studentAnswer)
                                        ? Colors.green
                                        : Colors.red,
                                    margin: EdgeInsets.only(bottom: 8.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Your Answer: ${answerDetails.studentAnswer}',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0, top: 4.0),
                                    child: Divider(
                                      height: 1.0,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
