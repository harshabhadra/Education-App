import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';

class Ebook extends StatefulWidget {
  Ebook({Key key}) : super(key: key);

  @override
  _EbookState createState() => _EbookState();
}

class _EbookState extends State<Ebook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(45),
                bottomRight: Radius.circular(45),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.repeated,
                    colors: [kPrimaryColor, Colors.deepPurpleAccent],
                  ),
                ),
                width: double.infinity,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'EBooks',
                          style: TextStyle(
                              fontFamily: 'Varela_Round',
                              fontSize: 48,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Today a reader, tomorrow a leader',
                          style: TextStyle(
                              fontFamily: 'Varela_Round',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text('All Categories',
                  style: TextStyle(
                      fontFamily: 'Varela_Round',
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            _buildEbooks()
          ],
        ),
      ),
    );
  }
}

Widget _buildEbooks() {
  RandomColor _randomColor = RandomColor();

  return GridView.count(
    physics: ScrollPhysics(),
    shrinkWrap: true,
    crossAxisCount: 2,
    children: List.generate(10, (index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Container(
            color: _randomColor.randomColor(),
            child: Center(
              child: Text(
                'Category $index',
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Varela_Round',
                    fontSize: 20),
              ),
            ),
          ),
        ),
      );
    }),
  );
}
