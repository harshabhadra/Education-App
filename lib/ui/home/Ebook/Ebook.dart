import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/database/DatabaseChapter.dart';
import 'package:education_app/utils/AppUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:random_color/random_color.dart';
import 'package:education_app/Bloc/bloc_provider.dart';
import 'package:education_app/Bloc/books_cache_bloc.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/ui/home/Ebook/EbookDetails.dart';
import 'package:education_app/utils/constants.dart';

class Ebook extends StatefulWidget {
  final String examType;
  final ProfileResponse profileResponse;
  const Ebook(
      {Key key, @required this.examType, @required this.profileResponse})
      : super(key: key);

  @override
  _EbookState createState() => _EbookState();
}

class _EbookState extends State<Ebook> {
  final bloc = BooksCacheBloc();
  bool isPurchaseAvail;

  @override
  void initState() {
    // Repository().refreshBooks(widget.examType);
    bloc.getBooks(widget.examType);
    if (widget.profileResponse.studentInfo.purchasedBook.isNotEmpty) {
      isPurchaseAvail = true;
    } else {
      isPurchaseAvail = false;
    }
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
      body: SafeArea(
        child: BlocProvider(
          bloc: bloc,
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                _buildEbookPage(context, bloc)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEbookPage(BuildContext context, BooksCacheBloc bloc) {
    return StreamBuilder(
        stream: bloc.booksStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else if (snapshot.hasData) {
              List<DatabaseBook> bookList = snapshot.data;
              var demoList = bloc.getBooksByType('Demo', bookList);
              var premiumList = bloc.getBooksByType('Premium', bookList);
              print('book list size in ui: ${bookList.length}');
              return Container(
                child: DefaultTabController(
                  length: isPurchaseAvail ? 3 : 2,
                  initialIndex: 0,
                  child: Column(
                    children: [
                      !isPurchaseAvail
                          ? TabBar(
                              labelColor: Colors.black,
                              tabs: [
                                Tab(
                                  text: 'Demo',
                                ),
                                Tab(
                                  text: 'Premium',
                                ),
                              ],
                            )
                          : TabBar(labelColor: Colors.black, tabs: [
                              Tab(
                                text: 'Demo',
                              ),
                              Tab(
                                text: 'Premium',
                              ),
                              Tab(text: 'Purchased')
                            ]),
                      Container(
                        height: MediaQuery.of(context)
                            .size
                            .height, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: !isPurchaseAvail
                            ? TabBarView(
                                children: [
                                  _buildBookList(demoList, context),
                                  _buildBookList(premiumList, context),
                                ],
                              )
                            : TabBarView(children: [
                                _buildBookList(demoList, context),
                                _buildBookList(premiumList, context),
                                _buildPurchasedList()
                              ]),
                      )
                    ],
                  ),
                ),
              );
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
    if (books.isNotEmpty) {
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
                            builder: (context) => EBookDetails(
                                  ebook: books[index],
                                  pBookList: widget.profileResponse.studentInfo
                                      .purchasedBook,
                                )));
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
                                    child: Text('COMING SOON',
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
    } else {
      return Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Text(
                "No Books Available",
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildPurchasedList() {
    RandomColor _randomColor = RandomColor();
    bool isChapter = false;
    List<PurchasedBook> books =
        widget.profileResponse.studentInfo.purchasedBook;

    return books.isNotEmpty
        ? AnimationLimiter(
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
                                builder: (context) => EBookDetails(
                                      ebook: getConvertedBook(books[index]),
                                      pBookList: books,
                                    )));
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              color: _randomColor.randomColor(
                                  colorBrightness: ColorBrightness.primary,
                                  colorSaturation:
                                      ColorSaturation.lowSaturation,
                                  colorHue: ColorHue.multiple(colorHues: [
                                    ColorHue.blue,
                                    ColorHue.purple
                                  ])),
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
                                            right: 8,
                                            left: 8,
                                            top: 4,
                                            bottom: 4),
                                        child: Text('COMING SOON',
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
          )
        : Container();
  }

  DatabaseBook getConvertedBook(PurchasedBook purchasedBook) {
    return DatabaseBook(
        bookName: purchasedBook.bookName,
        author: purchasedBook.author,
        bookID: purchasedBook.bookID,
        description: purchasedBook.description,
        listOfChapter: getPConvertedChapters(purchasedBook.listOfChapter),
        offer: purchasedBook.offer,
        price: purchasedBook.price,
        purchaseType: purchasedBook.purchaseType);
  }

  List<DbChapter> getPConvertedChapters(List<ListOfChapter> chapterList) {
    var dbChapterList = <DbChapter>{};
    for (var chapter in chapterList) {
      DbChapter dbChapter = DbChapter(
          catagory: chapter.catagory,
          chapterID: chapter.chapterID,
          pdfLink: chapter.pdfLink,
          title: chapter.title);
      dbChapterList.add(dbChapter);
    }
    return dbChapterList.toList();
  }
}
