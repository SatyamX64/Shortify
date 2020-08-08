import 'package:carousel_slider/carousel_slider.dart';
import 'package:emojis/emojis.dart';
import 'package:flutter/material.dart';
import 'package:shortify/Data/data_loader.dart';
import 'back_card_carousel.dart';

class BackCard extends StatelessWidget {
  final DataLoader dataLoader;
  final cardKey;
  BackCard({this.cardKey, this.dataLoader});
  @override
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      width: size.width * 0.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height / 72),
          color: Color(0xFFF1F1F1)),
      child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: size.height / 20,
              ),
              Expanded(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: size.height * 0.75,
                    viewportFraction: 1,
                  ),
                  items: <Widget>[
                    BackCardCarousel(
                      title: 'Browser',
                      code: 'bro',
                      map: dataLoader.browserDataMap,
                      emoji: Emojis.collision,
                    ),
                    BackCardCarousel(
                        title: 'Devices',
                        code: 'dev',
                        map: dataLoader.deviceDataMap,
                        emoji: Emojis.television),
                    BackCardCarousel(
                        title: 'OS',
                        code: 'os',
                        map: dataLoader.osDataMap,
                        emoji: Emojis.rocket),
                    BackCardCarousel(
                        title: 'Country',
                        code: 'geo',
                        map: dataLoader.countryDataMap,
                        emoji: Emojis.globeShowingAsiaAustralia),
                    BackCardCarousel(
                        title: 'Social',
                        code: 'social',
                        map: dataLoader.socialMediaDataMap,
                        emoji: Emojis.confettiBall),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width / 15, vertical: 10),
                child: GestureDetector(
                  onTap: () => cardKey.currentState.toggleCard(),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'No more .. ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: size.width / 20,
                      ),
                    ),
                    height: size.height / 20,
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(size.width / 50),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
