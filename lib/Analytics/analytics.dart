import 'dart:convert'; 
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shortify/Analytics/back_card.dart';
import 'package:shortify/Data/data_loader.dart';
import 'package:shortify/Network/network.dart';
import 'front_card.dart';

class Analytics {
  final String url;
  final context;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  Analytics({this.url,this.context});
  final networkLoader = NetworkLoader();
  Future<void> show() async {
    return showDialog(
      context: this.context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        return FutureBuilder(
          future: networkLoader.analytics(url),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              //Data Came back from API , stop Loading
              final Response response = snapshot.data;
              if (response.statusCode == 200) {
                // Desired Data Came back Successfully Show Analytics Page
                final data = jsonDecode(response.body);
                print(data);
                final dataLoader = DataLoader(data)..load();
                return FittedBox(
                  fit: BoxFit.none,
                  child: FlipCard(
                    key:
                        cardKey, // We assign a Key so we can Flip the card explicitly
                    flipOnTouch: false,
                    speed: 500,
                    back: BackCard(
                      // The Card Which Contains the Detailed Report
                      cardKey: cardKey,
                      dataLoader: dataLoader,
                    ),
                    front: FrontCard(dataLoader: dataLoader, cardKey: cardKey),
                  ),
                );
              } else // Data Came back but with a Error , so show error
                return FittedBox(
                  fit: BoxFit.none,
                  child: Container(
                    height: size.height * 0.75,
                    width: size.width * 0.75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(size.height / 72),
                        color: Color(0xFFF1F1F1)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: size.height * 0.75 / 3,
                        ),
                        Text(
                          'Error',
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: size.width / 10),
                        ),
                        SizedBox(
                          height: size.height * 0.75 / 10,
                        ),
                        Center(
                          child: Icon(
                            Icons.error,
                            color: Colors.red,
                            size: size.height * 0.75 / 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
            } else // Data has not yet come back , show Loading
              return FittedBox(
                fit: BoxFit.none,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.height / 72),
                      color: Color(0xFFF1F1F1)),
                  height: size.height * 0.75,
                  width: size.width * 0.75,
                  alignment: Alignment.center,
                  child: SizedBox(width: size.width*0.5,child: Lottie.asset('lottie/loading.json')),
                  // child: SizedBox(
                  //   height: size.height / 15,
                  //   child: LoadingIndicator(
                  //     indicatorType: Indicator.ballRotateChase,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ),
              );
          },
        );
      },
    );
  }
}

