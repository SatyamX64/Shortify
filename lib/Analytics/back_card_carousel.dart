import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';

class BackCardCarousel extends StatelessWidget {
  final Map map;
  final String code, title, emoji;
  BackCardCarousel({this.code, this.emoji, this.title, this.map});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$emoji $title',
          style: TextStyle(
              fontSize: size.height / 36, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: size.height / 25,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: map.length==0?Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Lottie.asset('lottie/analytics-bot.json'),
                Text('Not Enough Data for Analyisis',style: TextStyle(fontWeight: FontWeight.bold),textAlign: TextAlign.center,)
              ],
            )):ListView.separated(
                itemBuilder: (_, index) {
                  String key = map.keys.elementAt(index);
                  return Card(
                    child: ListTile(
                      leading: SizedBox(
                          height: size.height / 20,
                          width: size.height / 20,
                          child: code == 'geo'
                              ? Image.asset(
                                  'icons/flags/png/${key.toLowerCase()}.png',
                                  package: 'country_icons')
                              : SvgPicture.asset('icons/${code}_$key.svg')),
                      title: Text('$key'),
                      trailing: (code == 'social')
                          ? Text('${map[key].toInt()}')
                          : Text('${map[key]}'),
                    ),
                  );
                },
                separatorBuilder: (_, __) {
                  return SizedBox(
                    height: 5,
                  );
                },
                itemCount: map.length),
          ),
        )
      ],
    );
  }
}
