import 'package:carousel_slider/carousel_slider.dart';
import 'package:emojis/emojis.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shortify/Data/data_loader.dart';
import 'package:shortify/Analytics/front_card_carousel.dart';

class FrontCard extends StatelessWidget {
  const FrontCard({
    Key key,
    this.dataLoader,
    this.cardKey,
  }) : super(key: key);

  final DataLoader dataLoader;
  final GlobalKey<FlipCardState> cardKey;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.75,
      width: size.width * 0.75,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.height / 72),
          color: Color(0xFFF1F1F1)),
      child: SingleChildScrollView(
        child: Material(
          type: MaterialType.transparency,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: size.height / 20,
              ),
              Text(
                'Analytics',
                style: TextStyle(
                    fontSize: size.height / 36, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              PieChart(
                dataMap: dataLoader.socialMediaDataMap,
                animationDuration: Duration(milliseconds: 1800),
                chartLegendSpacing: 32.0,
                chartRadius: size.width / 4,
                showChartValuesInPercentage: false,
                showChartValues: false,
                showChartValuesOutside: false,
                chartValueBackgroundColor: Colors.grey[200],
                showLegends: true,
                legendPosition: LegendPosition.right,
                decimalPlaces: 0,
                showChartValueLabel: true,
                initialAngle: 0,
                chartValueStyle: defaultChartValueStyle.copyWith(
                  color: Colors.blueGrey[900].withOpacity(0.9),
                ),
                chartType: ChartType.ring,
              ),
              SizedBox(height: size.height / 15),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 12),
                child: Table(
                  // border: TableBorder.all(),
                  columnWidths: {0: FractionColumnWidth(0.1)},
                  children: [
                    TableRow(children: [
                      Text(
                        Emojis.tearOffCalendar,
                      ),
                      Text(
                        ' Created At : ',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dataLoader.generalDataMap['date'].toString(),
                        style: TextStyle(fontSize: size.width / 25),
                      ),
                    ]),
                    TableRow(children: [
                      Text(
                        Emojis.collision,
                      ),
                      Text(
                        ' Total Clicks : ',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        dataLoader.generalDataMap['clicks'].toString(),
                        style: TextStyle(fontSize: size.width / 25),
                      ),
                    ]),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 25,
              ),
              CarouselSlider(
                  options: CarouselOptions(
                      autoPlay: true,
                      autoPlayAnimationDuration: Duration(seconds: 300),
                      height: size.height / 6,viewportFraction: 1),
                      
                  items: [
                    FrontCardCarousel(
                      size: size,
                      clicks: dataLoader.generalDataMap['clicks'],
                      icon1: 'dev_Desktop',
                      icon2: 'dev_Mobile',
                      icon3: 'dev_Others',
                      stat1: dataLoader.deviceDataMap['Desktop'],
                      stat2: dataLoader.deviceDataMap['Mobile'],
                      stat3: dataLoader.deviceDataMap['Others'],
                      title1: 'Desktop',
                      title2: 'Mobile',
                      title3: 'Others',
                    ),
                    FrontCardCarousel(
                      size: size,
                      clicks: dataLoader.generalDataMap['clicks'],
                      icon1: 'os_Android',
                      icon2: 'os_iOS',
                      icon3: 'os_Windows',
                      stat1: dataLoader.osDataMap['Android'],
                      stat2: dataLoader.osDataMap['iOS'],
                      stat3: dataLoader.osDataMap['Windows'],
                      title1: 'Android',
                      title2: 'IOS',
                      title3: 'Windows',
                    ),
                  ]),
              SizedBox(
                height: size.height / 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width / 15),
                child: GestureDetector(
                  onTap: () => cardKey.currentState.toggleCard(),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'I Need more',
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
          ),
        ),
      ),
    );
  }
}
