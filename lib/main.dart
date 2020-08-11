import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'Models/url.dart';
import 'Widgets/homepage.dart';
import 'Theme/theme_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(URLAdapter());
  await Hive.openBox('urls');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    addDemoData();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: kPurple, //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: HomePage(),
        ));
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

// For Demo Purpose Only
void addDemoData() {
  var box = Hive.box('urls');
  box.add(
    URL(
        longURL: 'https://www.google.com',
        shortURL: 'https://cutt.ly/5dDAfYi',
        title: 'For Demo'),
  );
}
