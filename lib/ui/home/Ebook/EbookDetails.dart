import 'dart:io';

import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/database/DatabaseChapter.dart';
import 'package:education_app/ui/home/Ebook/Chapter_ui.dart';
import 'package:education_app/ui/payment/Payment_ui.dart';
import 'package:education_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:path_provider/path_provider.dart';

class EBookDetails extends StatefulWidget {
  final DatabaseBook ebook;

  const EBookDetails({Key key, @required this.ebook}) : super(key: key);

  @override
  _EBookDetailsState createState() => _EBookDetailsState();
}

class _EBookDetailsState extends State<EBookDetails> {
  List<DbChapter> chapterList;
  bool enable;
  @override
  void initState() {
    chapterList = widget.ebook.listOfChapter;
    enable = true;
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
      body: SingleChildScrollView(
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
              InkWell(
                onTap: () {
                  if (enable) _launchURL(widget.ebook.demoBookLink, 'Demo');
                  setState(() {
                    enable = false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 8,
                    child: Column(
                      children: [
                        Flexible(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/pdf_icon.png'),
                        )),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.grey[200],
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Demo Version',
                                style: TextStyle(
                                    fontFamily: 'Varela_Round',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GridView.count(
                crossAxisCount: 2,
                physics: ScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(chapterList.length, (index) {
                  return InkWell(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                          builder: (context) {
                            return Container(
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('You need to Purchase Premium',
                                        style: TextStyle(fontSize: 18)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    child: RaisedButton(
                                      color: kPrimaryColor,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (context) {
                                          return PaymentUi();
                                        }));
                                      },
                                      child: Text('Purchae Premium',
                                          style: TextStyle(
                                              color: Colors.white, fontSize: 18)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                          elevation: 4,
                          child: Stack(children: [
                            Center(
                              child: Flexible(
                                  child: Container(
                                      margin: EdgeInsets.fromLTRB(8, 8, 8, 32),
                                      child: Image.asset(
                                          'assets/images/pdf_icon.png'))),
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
                  );
                }),
              )
            ],
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
