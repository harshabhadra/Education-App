import 'package:education_app/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

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
    secureScreen();
    super.initState();
  }

  Future<void> secureScreen() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PDFViewerScaffold(
        path: widget.url,
      ),
    );
  }
}
