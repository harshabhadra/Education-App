import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/leaderboard_bloc.dart';
import 'package:education_app/Model/error_model.dart';
import 'package:education_app/Model/leaderboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LeaderBoardScreen extends StatefulWidget {
  final int examId;
  LeaderBoardScreen({Key key, this.examId}) : super(key: key);

  @override
  _LeaderBoardScreenState createState() => _LeaderBoardScreenState();
}

class _LeaderBoardScreenState extends State<LeaderBoardScreen> {
  LeaderBoardBloc _bloc = LeaderBoardBloc();

  @override
  void initState() {
    _bloc.getLeaderBoard(widget.examId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          bloc: _bloc,
          child: _buildLeaderBoardPage(),
        ),
      ),
    );
  }

  Widget _buildLeaderBoardPage() {
    return StreamBuilder(
        stream: _bloc.leaderBoardStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic> map = snapshot.data;
              if (map.containsKey('leaderBoardList')) {
                LeaderBoard leaderBoard = LeaderBoard.fromJson(map);
                List<LeaderBoardList> _leaderboardList =
                    leaderBoard.leaderBoardList;
                print('leaderboard list size: ${_leaderboardList.length}');
                return _buildList(_leaderboardList);
              } else {
                ErrorModel errorModel = map['error'];
                return Center(
                  child: Text(errorModel.description),
                );
              }
              return Container();
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

  Widget _buildList(List<LeaderBoardList> leaderboardList) {
    return SingleChildScrollView(
      physics: ClampingScrollPhysics(),
          child: Container(
        color: Colors.blueAccent[100],
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: SvgPicture.asset('assets/images/result.svg'))),
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Leader Board',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          separatorBuilder: (context, index) {
                            return Divider(height: 1.0);
                          },
                          itemCount: leaderboardList.length,
                          itemBuilder: (context, index) {
                            LeaderBoardList leaderboard = leaderboardList[index];
                            return Container(
                              margin: EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "${leaderboard.email}",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Marks: ${leaderboard.markObtained.toString()}',
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 18.0),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
