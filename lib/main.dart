import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'Widgets/homepage.dart';
import 'Data/data_repository.dart';
import 'Theme/theme_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.blue, //top bar color
      statusBarIconBrightness: Brightness.light, //top bar icons
      systemNavigationBarColor: Colors.white, //bottom bar color
      systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
    ));
    return ChangeNotifierProvider<DataRepository>(
      create: (context) => DataRepository(),
      child: MaterialApp(
        theme: themeData,
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: HomePage())),
    );
  }
}
