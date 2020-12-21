import 'package:education_app/Bloc/Repository.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/books_cache_bloc.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/ui/home/Ebook/EbookDetails.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:random_color/random_color.dart';

class Ebook extends StatefulWidget {
  Ebook({Key key}) : super(key: key);

  @override
  _EbookState createState() => _EbookState();
}

class _EbookState extends State<Ebook> {
  final bloc = BooksCacheBloc();

  @override
  void initState() {
    Repository().refreshBooks();
    bloc.getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: BlocProvider(
        bloc: bloc,
        child: SingleChildScrollView(
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
                child: Text('All Books',
                    style: TextStyle(
                        fontFamily: 'Varela_Round',
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
              ),
              _buildEbooks(bloc, context)
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildEbooks(BooksCacheBloc bloc, BuildContext context) {
  return StreamBuilder(
      stream: bloc.booksStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          } else if (snapshot.hasData) {
            List<DatabaseBook> bookList = snapshot.data;
            print('book list size in ui: ${bookList.length}');
            return _buildBookList(bookList, context);
          } else {
            return Center(
              child: Text('snap shot has no data'),
            );
          }
        } else {
          print(
              'Snapshot connection state: ${snapshot.connectionState.toString()}');
          return Center(
            child: Container(
              child: CircularProgressIndicator(),
            ),
          );
        }
      });
}

Widget _buildBookList(List<DatabaseBook> books, BuildContext context) {
  bool isChapter = false;

  RandomColor _randomColor = RandomColor();
  return AnimationLimiter(
    child: GridView.count(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(books.length, (index) {
        books[index].listOfChapter.isNotEmpty
            ? isChapter = true
            : isChapter = false;
        return AnimationConfiguration.staggeredGrid(
          position: index,
          duration: const Duration(milliseconds: 1000),
          columnCount: 2,
          child: ScaleAnimation(
            child: FadeInAnimation(
              child: InkWell(
                splashColor: Colors.white,
                onTap: () {
                  if (isChapter) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            EBookDetails(ebook: books[index])));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    child: Container(
                      color: _randomColor.randomColor(
                          colorBrightness: ColorBrightness.primary,
                          colorSaturation: ColorSaturation.lowSaturation,
                          colorHue: ColorHue.multiple(
                              colorHues: [ColorHue.blue, ColorHue.purple])),
                      child: Stack(children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.all(10.0),
                          child: Text(
                            '${books[index].bookName}',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Varela_Round',
                                fontSize: 20),
                          ),
                        ),
                        if (!isChapter)
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.all(8),
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    right: 8, left: 8, top: 4, bottom: 4),
                                child: Text('PREVIEW ONLY',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Varela_Round',
                                        fontSize: 16)),
                              ),
                            ),
                          )
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    ),
  );
}
