import 'dart:io';

import 'package:education_app/Model/profile_response.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/database/DatabaseChapter.dart';
import 'package:education_app/ui/home/Ebook/Chapter_ui.dart';
import 'package:education_app/ui/payment/Payment_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';

class EBookDetails extends StatefulWidget {
  final DatabaseBook ebook;
  final List<PurchasedBook> pBookList;

  const EBookDetails({Key key, @required this.ebook, @required this.pBookList})
      : super(key: key);

  @override
  _EBookDetailsState createState() => _EBookDetailsState();
}

class _EBookDetailsState extends State<EBookDetails> {
  List<DbChapter> chapterList;
  bool enable, isPurchased;
  List<int> bookIdList = [];
  @override
  void initState() {
    chapterList = widget.ebook.listOfChapter;
    enable = true;
    if (widget.pBookList.isNotEmpty) {
      for (PurchasedBook book in widget.pBookList) {
        bookIdList.add(book.bookID);
      }
      bookIdList.contains(widget.ebook.bookID)
          ? isPurchased = true
          : isPurchased = false;
      if (bookIdList.contains(widget.ebook.bookID)) {
        isPurchased = true;
        print('book purchased');
      } else {
        isPurchased = false;
        print('book not purchased');
      }
    } else {
      isPurchased = false;
      print('book not purchased');
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
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: AnimationLimiter(
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
                              '${widget.ebook.bookName}',
                              style: TextStyle(
                                  fontFamily: 'Varela_Round',
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${widget.ebook.author}',
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
                GridView.count(
                  crossAxisCount: 2,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(chapterList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          if (widget.ebook.purchaseType == 'Demo') {
                            if (enable) {
                              setState(() {
                                enable = false;
                              });
                              _launchURL(chapterList[index].pdfLink,
                                  chapterList[index].title);
                            }
                          } else {
                            if (isPurchased) {
                              setState(() {
                                enable = false;
                              });
                              _launchURL(chapterList[index].pdfLink,
                                  chapterList[index].title);
                            } else {
                              showModalBottomSheet(
                                  context: context,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(24),
                                          topRight: Radius.circular(24))),
                                  builder: (context) {
                                    return Container(
                                      margin: EdgeInsets.fromLTRB(8, 24, 8, 0),
                                      child: Stack(
                                        children: [
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Lottie.asset(
                                                    'assets/raw/book.json',
                                                    height: 120,
                                                    fit: BoxFit.fill),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                      '${widget.ebook.bookName}',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                      'Written by : ${widget.ebook.author}',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8),
                                                  child: Text(
                                                      'Price : ₹${widget.ebook.price}',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600)),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0,
                                                          bottom: 16),
                                                  child: Text(
                                                      'Discount : ₹${widget.ebook.offer}',
                                                      style: TextStyle(
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              bottom: 8.0),
                                                      child: Text(
                                                          'Sub Total : ₹${int.parse(widget.ebook.price) - int.parse(widget.ebook.offer)}',
                                                          style: TextStyle(
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500)),
                                                    ),
                                                    RaisedButton(
                                                      color: kPrimaryColor,
                                                      onPressed: () {
                                                        Navigator.of(context).push(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) {
                                                          return PaymentUi(
                                                            price: (int.parse(
                                                                    widget.ebook
                                                                        .price) -
                                                                int.parse(widget
                                                                    .ebook
                                                                    .offer)),
                                                            bookId: widget
                                                                .ebook.bookID,
                                                          );
                                                        }));
                                                      },
                                                      child: Text('Buy Now',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 18)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  });
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                              elevation: 4,
                              child: Stack(children: [
                                Center(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(8, 8, 8, 32),
                                      child: Image.asset(
                                          'assets/images/pdf_icon.png')),
                                ),
                                Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          'Chapter ${index + 1}',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ))),
                              ])),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _launchURL(String url, String title) async {
    createFileOfPdfUrl(url).then((value) {
      setState(() {
        enable = true;
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return ChapterUi(url: value.path, title: title);
        }));
      });
    });
  }

  Future<File> createFileOfPdfUrl(String url) async {
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}
