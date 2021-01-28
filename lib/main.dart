import 'package:education_app/Model/LoginResponse.dart';
import 'package:education_app/database/DatabaseBook.dart';
import 'package:education_app/database/DatabaseChapter.dart';
import 'package:education_app/database/DatabaseLogin.dart';
import 'package:education_app/ui/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

List<Box> boxList = [];
Future<List<Box>> _openBox() async {
  var dir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(DatabaseBookAdapter());
  Hive.registerAdapter(DbChapterAdapter());
  Hive.registerAdapter(DatabaseLoginAdapter());
  Hive.registerAdapter(LoginResponseAdapter());
  var categoryBox = await Hive.openBox("category");
  var bookBox = await Hive.openBox('books');
  var userBox = await Hive.openBox('user');
  var credBox = await Hive.openBox('cred');
  boxList.add(categoryBox);
  boxList.add(bookBox);
  boxList.add(userBox);
  boxList.add(credBox);
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
        debugShowCheckedModeBanner: false,
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
