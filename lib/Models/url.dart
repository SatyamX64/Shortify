import 'package:hive/hive.dart';
part 'url.g.dart';

@HiveType(typeId : 0)
class URL extends HiveObject {
  @HiveField(0)
  final String longURL;

  @HiveField(1) 
  final String shortURL;

  @HiveField(2) 
  final String title;

  URL({this.longURL, this.shortURL, this.title});
}
