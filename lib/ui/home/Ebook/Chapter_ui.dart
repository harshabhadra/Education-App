import 'package:education_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';

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
    return PDFViewerScaffold(
      path: widget.url,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(widget.title),
      ),
    );
  }
}
