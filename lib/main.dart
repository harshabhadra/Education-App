import 'package:education_app/database/DatabaseVideo.dart';
import 'package:education_app/ui/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

List<Box> boxList = [];
Future<List<Box>> _openBox() async {
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(DatabaseVideoListAdapter());
  var categoryBox = await Hive.openBox("category");
  var videoBox = await Hive.openBox("videos");
  boxList.add(categoryBox);
  boxList.add(videoBox);
  return boxList;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.white,
      body: Splash(),
    ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}