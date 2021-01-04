import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/exam_info_bloc.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/exam_info.dart';
import 'package:education_app/ui/home/exam/start_exam_ui.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:random_color/random_color.dart';

class ExamInfoScreen extends StatefulWidget {
  ExamInfoScreen({Key key}) : super(key: key);

  @override
  _ExamInfoScreenState createState() => _ExamInfoScreenState();
}

class _ExamInfoScreenState extends State<ExamInfoScreen> {
  ExamInfoBloc bloc;
  final String assetName = 'assets/images/onile_test.svg';
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    bloc = ExamInfoBloc();
    bloc.getExamInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[50],
        elevation: 0.0,
        title: Text(
          "Exams",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: BlocProvider(
            bloc: bloc,
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        ),
                        child: Container(
                            color: Colors.blue[50],
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SvgPicture.asset(
                                    'assets/images/online_test.svg'))),
                      ),
                    ),
                    Container(child: _buildResults(bloc)),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget _buildResults(ExamInfoBloc bloc) {
    return StreamBuilder(
      stream: bloc.examInfoStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            Map<String, dynamic> map = snapshot.data;
            return _buildExamList(map);
          } else {
            return Center(
              child: Text("No Data"),
            );
          }
        } else {
          print(
              'Snapshot connection state: ${snapshot.connectionState.toString()}');
          return Center(
            child: Container(
              margin: EdgeInsets.all(24.0),
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget _buildExamList(Map<String, dynamic> map) {
    var list = map.values.toList();
    ExamInfo exam = list[0];
    ErrorModel errorModel = list[1];
    RandomColor _randomColor = RandomColor();
    List<Exam> examList = [];

    if (exam != null) {
      var tExamList = exam.examList;

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Future ft = Future(() {});

        tExamList.forEach((Exam exam) {
          ft = ft.then((value) {
            return Future.delayed(Duration(milliseconds: 100), () {
              examList.add(exam);
              listKey.currentState.insertItem(examList.length - 1,
                  duration: Duration(seconds: 1));
            });
          });
        });
      });

      return AnimatedList(
        key: listKey,
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset(0, 0),
            ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeInSine,
                reverseCurve: Curves.easeIn)),
            child: InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StartExamScreen(exam: examList[index]);
                }));
              },
              child: Card(
                color: _randomColor.randomColor(
                    colorBrightness: ColorBrightness.primary,
                    colorSaturation: ColorSaturation.lowSaturation,
                    colorHue: ColorHue.multiple(
                        colorHues: [ColorHue.blue, ColorHue.purple])),
                elevation: 8.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                margin: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ExpandablePanel(
                        iconColor: Colors.white,
                        header: Text(
                          examList[index].examCatagory,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontFamily: 'Varela_Round',
                              fontWeight: FontWeight.bold),
                        ),
                        collapsed: Text(
                          examList[index].examDescription,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                        expanded: Text(
                          examList[index].examDescription,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Text(
                        'No. of Questions: ' +
                            examList[index].totalNumberOfQuestion,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            "Marks: " + examList[index].totalMark,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Varela_Round',
                              color: Colors.white,
                            ),
                          ),
                          Spacer(
                            flex: 1,
                          ),
                          Text('Duration: ' + examList[index].examDuraction,
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Varela_Round',
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
        initialItemCount: 0,
      );
    } else {
      return Center(
        child: Text(errorModel.description),
      );
    }
  }
}
