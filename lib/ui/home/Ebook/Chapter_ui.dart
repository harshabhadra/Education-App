import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class ChapterUi extends StatefulWidget {
  final String url;
  final String title;

  const ChapterUi({Key key, @required this.url, @required this.title})
      : super(key: key);

  @override
  _ChapterUiState createState() => _ChapterUiState();
}

class _ChapterUiState extends State<ChapterUi> {
  String pdfPath = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: PDF(
          enableSwipe: true,
          swipeHorizontal: false,
          autoSpacing: false,
          pageFling: false,
          onError: (error) {
            print(error.toString());
          },
          onPageError: (page, error) {
            print('$page: ${error.toString()}');
          },
          onPageChanged: (int page, int total) {
            print('page change: $page/$total');
          },
        ).fromUrl("https://firebasestorage.googleapis.com/v0/b/aksphysiology-6b01c.appspot.com/o/1621586414T64500014148502052021132513.pdf?alt=media"),
      ),
    );
  }
}
