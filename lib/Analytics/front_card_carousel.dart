import 'package:flutter/material.dart';
import 'package:shortify/Analytics/front_card_carousel_child.dart';

class FrontCardCarousel extends StatelessWidget {
  const FrontCardCarousel(
      {Key key,
      @required this.size,
      this.clicks,
      this.icon1,
      this.icon2,
      this.icon3,
      this.stat1,
      this.stat2,
      this.stat3,
      this.title1,
      this.title2,
      this.title3,})
      : super(key: key);

  final Size size;
  final icon1, icon2, icon3;
  final stat1, stat2, stat3,clicks;
  final title1, title2, title3;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      // margin: EdgeInsets.symmetric(horizontal: size.width / 20),
      // padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          FrontCardCarouselChild(
            icon: icon1,
            value: stat1,
            title: title1,
            color: Color(0xFFa29bfe),
            clicks: int.parse(clicks),
          ),
          // SizedBox(
          //   width: size.width / 36,
          // ),
          FrontCardCarouselChild(
            icon: icon2,
            value: stat2,
            title: title2,
            color: Color(0xFFff7675),
            clicks: int.parse(clicks),
          ),
          // SizedBox(
          //   width: size.width / 36,
          // ),
          FrontCardCarouselChild(
            icon: icon3,
            value: stat3,
            title: title3,
            color: Color(0xFFa29bfe),
            clicks: int.parse(clicks),
          ),
        ],
      ),
    );
  }
}
