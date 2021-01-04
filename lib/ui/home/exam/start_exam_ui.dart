import 'package:education_app/ui/home/exam/exam_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:education_app/Model/exam_info.dart';

class StartExamScreen extends StatefulWidget {
  final Exam exam;
  const StartExamScreen({
    Key key,
    @required this.exam,
  }) : super(key: key);

  @override
  _StartExamScreenState createState() => _StartExamScreenState();
}

class _StartExamScreenState extends State<StartExamScreen> {
  Exam exam;
  @override
  void initState() {
    exam = widget.exam;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          exam.examCatagory,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'No. of Questions: ' + exam.totalNumberOfQuestion,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Text(
                          'Marks: ' + exam.totalMark,
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          'Duration : ' + exam.examDuraction + ' min',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8, right: 8, top: 16),
                      width: MediaQuery.of(context).size.width,
                      height: 1.0,
                      color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Exam Instructions',
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
                      child: Text(
                          '(Read instructions carefully before starting the exam)'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      exam.examDescription,
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        'No. of Student Attended: ' +
                            exam.totalNumberOfStudentsAttended.toString(),
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Row(
                      children: [
                        Text(
                          'Average Mark: ' + exam.averageMarkTillNow.toString(),
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Spacer(),
                        Text(
                          'Top Score : ' + exam.highestMarkTillNow.toString(),
                          style: TextStyle(fontSize: 18.0),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.grey[100],
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                  child: RaisedButton(
                    onPressed: () {
                      startExam(exam);
                    },
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'START EXAM',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Future<dynamic> startExam(Exam exam) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text('Start The exam'),
            content: Text(
                'Once You Start The Exam your need to complete the exam in ' +
                    exam.examDuraction +
                    ' min'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.red),
                  )),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                onPressed: () {
                  Navigator.of(context).pop();
                  _goToExamScreen(exam);
                },
                color: kPrimaryColor,
                child: Text(
                  'Start',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        });
  }

  void _goToExamScreen(Exam exam) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ExamScreen(exam: exam,)));
  }
}
