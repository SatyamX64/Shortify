import 'package:flutter/material.dart';
import 'package:shortify/Models/url_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DataRepository extends ChangeNotifier {
  List<URL> dataList = [];
  delete(int index) {
    dataList.removeAt(index);
    notifyListeners();
  }

  launchURL(int index) async {
    if (await canLaunch(dataList[index].shortURL)) {
      await launch(dataList[index].shortURL);
    } else {
      throw 'Could not launch ${dataList[index].shortURL}';
    }
  }

  addData(URL url) {
    dataList.insert(0,url);
    notifyListeners();
  }
}
