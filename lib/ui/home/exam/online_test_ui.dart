import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/exam_questions_bloc.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/exam_info.dart';
import 'package:education_app/Model/exam_questions_model.dart';
import 'package:education_app/Network/submit_test_request.dart';
import 'package:education_app/ui/home/exam/test_report_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';

class OnlineTestScreen extends StatefulWidget {
  final Exam exam;
  OnlineTestScreen({Key key, this.exam}) : super(key: key);

  @override
  _OnlineTestScreenState createState() => _OnlineTestScreenState();
}

class _OnlineTestScreenState extends State<OnlineTestScreen> {
  ExamQuestionsBloc bloc = ExamQuestionsBloc();
  CountDownController _countDownController;
  String totalMarks;
  int studentMarks = 0;
  bool canSubmit = false;
  Exam _exam;
  String _groupValue;
  int currentPosition;
  List<AnswerDetails> answerList = List();
  List<QuestioListExamWise> questionsList;
  String correctValue;
  QuestioListExamWise questioListExamWise;

  @override
  void initState() {
    _exam = widget.exam;
    bloc.getAllQuestions(_exam.examId);
    currentPosition = 0;
    totalMarks = _exam.totalMark;
    _countDownController = CountDownController();

    super.initState();
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

  Future<dynamic> _showScoreDialog() {
    Dialog _scoreDialog = Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 200,
        child: Center(
          child: Column(
            children: [
              Container(
                height: 60,
                width: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Lottie.asset('assets/raw/done.json', repeat: false),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Total Marks: $totalMarks',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Your Score: $studentMarks',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _goToReportScreen();
                  },
                  child: Text('Details Report'))
            ],
          ),
        ),
      ),
    );
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return _scoreDialog;
        });
  }

  void _goToReportScreen() {
    var credBox = Hive.box('cred');
    String email = credBox.get('email');
    SubmitTestRequest _submitTestRequest = SubmitTestRequest(
        email: email,
        examId: _exam.examId,
        totalMark: int.parse(_exam.totalMark),
        markObtained: studentMarks,
        examDetails: answerList);

    _goToReport(_submitTestRequest, questionsList);
  }

  //Go to report screen
  void _goToReport(SubmitTestRequest _submitTestRequest,
      List<QuestioListExamWise> _questionsList) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return TestReportScreen(
        submitTestRequest: _submitTestRequest,
        questionsList: _questionsList,
        examId: widget.exam.examId,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(_exam.examCatagory),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocProvider(
            bloc: bloc,
            child: _buildTestPage(),
          ),
        ),
      ),
    );
  }

  Widget _buildTestPage() {
    ExamQuestions examQuestions;
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
                if (examQuestions.examAttened == null) {
                  questionsList = examQuestions.questioListExamWise;
                  return questionsList.length == 0
                      ? Center(child: Text('No Questions available'))
                      : _buildQuestionsList(questionsList);
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('You have already attended the exam'),
                            actions: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _goToReport(examQuestions.examAttened,
                                        examQuestions.questioListExamWise);
                                  },
                                  child: Text('Show Report'),
                                ),
                              ),
                            ],
                          );
                        },
                        barrierDismissible: false);
                  });
                }
                return Container();
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
    // questionsList.map((e) => totalMarks += e.questionMark);
    var duration = int.parse(_exam.examDuraction) * 60;
    return Stack(children: [
      Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text('Duration: ${_exam.examDuraction} min',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Spacer(),
                  CircularCountDownTimer(
                    width: 90,
                    height: 90,
                    duration: duration,
                    controller: _countDownController,
                    fillColor: Colors.red,
                    color: Colors.green,
                    onComplete: () {
                      _showScoreDialog();
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildOptions(questionsList[currentPosition]),
        ],
      ),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: (currentPosition == questionsList.length - 1)
                ? RaisedButton(
                    onPressed: () {
                      if (_groupValue == correctValue) {
                        studentMarks += questioListExamWise.questionMark;
                        print("Score: $studentMarks");
                      } else {
                        if (studentMarks - questioListExamWise.questionMark >=
                            0) {
                          studentMarks -= questioListExamWise.questionMark;
                          print("Score: $studentMarks");
                        }
                      }
                      answerList.add(AnswerDetails(
                          questionId: questioListExamWise.questionId,
                          questionAnswer: correctValue,
                          studentAnswer: _groupValue));
                      print(
                          "no. of answers: ${answerList.length}, ${answerList.toString()}");
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Submit Answers & Get Score'),
                              actions: [
                                TextButton(
                                  child: Text('Submit'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    _showScoreDialog();
                                  },
                                ),
                                TextButton(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          });
                    },
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Submit', style: TextStyle(color: Colors.white)),
                    ),
                  )
                : RaisedButton(
                    onPressed: () {
                      setState(() {
                        if (_groupValue == correctValue) {
                          studentMarks += questioListExamWise.questionMark;
                          print("Score: $studentMarks");
                        } else {
                          if (studentMarks - questioListExamWise.questionMark >=
                              0) {
                            studentMarks -= questioListExamWise.questionMark;
                            print("Score: $studentMarks");
                          }
                        }
                        answerList.add(AnswerDetails(
                            questionId: questioListExamWise.questionId,
                            questionAnswer: correctValue,
                            studentAnswer: _groupValue));
                        print(
                            "no. of answers: ${answerList.length}, ${answerList.toString()}");
                        if (currentPosition < questionsList.length - 1) {
                          currentPosition++;
                          print('current position: $currentPosition');
                        } else {
                          print('questions end');
                        }
                      });
                    },
                    color: kPrimaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                          Text('Next', style: TextStyle(color: Colors.white)),
                    ),
                  ),
          ),
        ),
      )
    ]);
  }

  Widget _buildOptions(QuestioListExamWise question) {
    questioListExamWise = question;
    List<String> _options = questioListExamWise.questionOptions;
    correctValue = questioListExamWise.questionAnswer;
    print("Correct value: $correctValue");

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Marks: ' + questioListExamWise.questionMark.toString(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
            child: Text(
              'Q. ${questioListExamWise.questionDescription}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          questioListExamWise.questionImage != ""
              ? Image.network(
                  questioListExamWise.questionImage,
                  width: MediaQuery.of(context).size.width,
                  height: 160,
                  fit: BoxFit.fill,
                )
              : Container(),
          ListView.builder(
              shrinkWrap: true,
              itemCount: _options.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_options[index]),
                  leading: Radio(
                      value: _options[index],
                      groupValue: _groupValue,
                      onChanged: (String s) {
                        setState(() {
                          _groupValue = s;
                          print(_groupValue);
                        });
                      }),
                );
              }),
        ],
      ),
    );
  }
}
