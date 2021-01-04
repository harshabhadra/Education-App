import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/exam_questions_model.dart';
import 'package:flutter/material.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/exam_questions_bloc.dart';
import 'package:education_app/Model/exam_info.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter_countdown_timer/countdown.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';

class ExamScreen extends StatefulWidget {
  final Exam exam;
  const ExamScreen({
    Key key,
    @required this.exam,
  }) : super(key: key);

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  ExamQuestionsBloc bloc = ExamQuestionsBloc();
  CountdownController _countDownController;
  String _selectedValue = '';
  List<String> selectedValueList = [''];
  double totalMarks;
  double studentMarks = 0.0;
  bool canSubmit = false;
  @override
  void initState() {
    int examId = widget.exam.examId;
    bloc.getAllQuestions(examId);
    _countDownController =
        CountdownController(duration: Duration(seconds: 265));
    super.initState();
  }

  @override
  void dispose() {
    _countDownController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        body:
            SafeArea(child: BlocProvider(bloc: bloc, child: _buildPages(bloc))),
      ),
    );
  }

  Widget _buildPages(ExamQuestionsBloc bloc) {
    ExamQuestions examQuestions;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _countDownController.start();
    });

    return StreamBuilder(
        stream: bloc.questionsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic> map = snapshot.data;
              examQuestions = map['questions'];
              if (examQuestions != null) {
                List<QuestioListExamWise> questionsList =
                    examQuestions.questioListExamWise;

                questionsList.add(examQuestions.questioListExamWise.first);
                for (int i = 1; i < questionsList.length; i++) {
                  selectedValueList.add('');
                }
                return questionsList.length == 0
                    ? Center(child: Text('No Questions available'))
                    : _buildQuestionsList(questionsList);
              } else {
                ErrorModel errorModel = map['error'];
                return Center(
                  child: Text(errorModel.description),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildQuestionsList(List<QuestioListExamWise> questionsList) {
    questionsList.map((e) => totalMarks += e.questionMark);
    return Stack(children: [
      Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Card(
            elevation: 6.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Countdown(
                    countdownController: _countDownController,
                    builder: (context, time) {
                      if (time.inSeconds == 0) {
                        return Text('Times Up');
                      } else {
                        return time.inSeconds > 59
                            ? Text(
                                'Time Remaining: ${time.inMinutes}:${time.inSeconds}',
                                style: TextStyle(fontSize: 20),
                              )
                            : Text(
                                'Time Remaining: ${time.inSeconds.toString()}',
                                style: TextStyle(fontSize: 20));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: PageView.builder(
              itemCount: questionsList.length,
              itemBuilder: (context, position) {
                // for (QuestioListExamWise question in questionsList) {
                //   totalMarks += question.questionMark;
                // }
                QuestioListExamWise questioListExamWise =
                    questionsList[position];
                List<String> options =
                    questioListExamWise.questionOptions; //Optons list
                String correctValue = questioListExamWise.questionAnswer;
                return SingleChildScrollView(
                  physics: ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Marks: ' +
                                  questioListExamWise.questionMark.toString(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Q. What is the best Programming language?',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (context, index) {
                            return RadioListTile<String>(
                                title: Text(options[index]),
                                value: options[index],
                                groupValue: selectedValueList[position],
                                toggleable: true,
                                activeColor: kPrimaryColor,
                                onChanged: (value) {
                                  setState(() {
                                    print("Selected value : " + value);
                                    if (value == correctValue) {
                                      studentMarks +=
                                          questioListExamWise.questionMark;
                                      canSubmit = true;
                                    }
                                  });
                                });
                          }),
                    ],
                  ),
                );
              }),
        )
      ]),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                _showScoreDialog();
              },
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ),
      )
    ]);
  }

  Future<dynamic> _showScoreDialog() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: Text('Your Score'),
            content: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Your Score: $studentMarks'),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  Future<bool> _onBackPress() {
    return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Do you want to Quit the Exam?'),
                content: Text('Click YES if you want to quit'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text(
                        'YES',
                        style: TextStyle(color: Colors.red),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      child: Text(
                        'No, Continue',
                        style: TextStyle(color: Colors.deepPurple),
                      ))
                ],
              );
            }) ??
        false;
  }
}
