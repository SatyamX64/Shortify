import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FrontCardCarouselChild extends StatelessWidget {
  final String title, icon;
  final int value,clicks;
  final color;
  FrontCardCarouselChild({this.clicks,this.color, this.icon, this.title, this.value});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: size.width / 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: size.width / 12,
              child: SvgPicture.asset('icons/$icon.svg'),
            ),
            Text('${(value/clicks*100).toStringAsFixed(0)}%',
              // value.toString(),
              style: TextStyle(
                  color: color,
                  fontSize: size.height / 40,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
