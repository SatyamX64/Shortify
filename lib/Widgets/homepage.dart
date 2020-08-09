import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shortify/Data/data_repository.dart';
import 'package:shortify/Models/url_model.dart';
import 'package:shortify/Network/network.dart';
import 'package:shortify/Theme/theme_data.dart';
import 'package:shortify/Widgets/error_box.dart';
import 'package:shortify/Widgets/url_card.dart';
import 'package:string_validator/string_validator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final dataRepository = Provider.of<DataRepository>(context);
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    final networkLoader = NetworkLoader();
    final urlController = TextEditingController();
    final titleController = TextEditingController();
    final customController = TextEditingController();
    return SafeArea(
      child: Form(
        key: _formKey,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              centerTitle: true,
              title: Text(
                'URL Shortener',
                style: TextStyle(
                    fontWeight: FontWeight.w900, fontSize: size.width / 15),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed(
                [
                  SizedBox(height: size.height / 72),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 36),
                    child: TextFormField(
                      controller: urlController,
                      enabled: !_loading,
                      decoration: InputDecoration(hintText: 'Enter Long URL'),
                      validator: (value) => isURL(value) ? null : 'Invalid URL',
                      style: kTextFieldContentStyle,
                    ),
                  ),
                  SizedBox(
                    height: size.height / 36,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 36),
                      child: TextFormField(
                        controller: titleController,
                        enabled: !_loading,
                        decoration: InputDecoration(hintText: 'Enter Title'),
                        style: kTextFieldContentStyle,
                      )),
                  SizedBox(
                    height: size.height / 36,
                  ),
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 36),
                      child: TextFormField(
                        controller: customController,
                        enabled: !_loading,
                        decoration:
                            InputDecoration(hintText: 'Enter Custom Code'),
                        style: kTextFieldContentStyle,
                      )),
                  SizedBox(
                    height: size.height / 36,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width / 4),
                    child: SizedBox(
                      height: size.height / 24,
                      child: _loading == true
                          ? RaisedButton(
                              color: Colors.blue,
                              child: LoadingIndicator(
                                indicatorType: Indicator.ballPulse,
                                color: Colors.white,
                              ),
                              onPressed:
                                  () {}, // Pressing Button while Loading should not do anything
                            )
                          : RaisedButton(
                              child: Text(
                                'Create Short URL',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: size.width / 24,
                                ),
                              ),
                              onPressed: () async {
                                var connectivityResult = await (Connectivity()
                                    .checkConnectivity()); // Checks If Internet is Available
                                if (_formKey.currentState.validate() &&
                                    connectivityResult !=
                                        ConnectivityResult.none) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  Response response =
                                      await networkLoader.shortenURL(
                                          url: urlController.text
                                                  .contains('https')
                                              ? urlController.text
                                              : 'https://' + urlController.text,
                                          customCode: customController.text);
                                  setState(() {
                                    _loading = false;
                                  });
                                  print(response);
                                  if (response.statusCode == 200) {
                                    final data = jsonDecode(response.body);
                                    int status = data['url']['status'];
                                    if (status == 7) {
                                      //Status 7 Means Success in this API
                                      dataRepository.addData(
                                        URL(
                                          longURL: data['url']['fullLink'],
                                          shortURL: data['url']['shortLink'],
                                          title: titleController.text.length < 1
                                              ? data['url']['title']
                                              : titleController.text,
                                        ),
                                      );
                                    } else
                                      errorBox(
                                          context: context, status: status);
                                  } else
                                    errorBox(context: context, status: 8);
                                } else if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  Scaffold.of(context).showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.blue,
                                      content: Text(
                                        'That thing needs an Active Connection',
                                        style: TextStyle(
                                            fontFamily: 'Sen',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                              },
                              color: Colors.blue,
                            ),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 36,
                  ),
                ],
              ),
            ),
            SliverAppBar(
              pinned: true,
              title: Text(
                'Shortened URLs',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: size.height / 36),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return URLCard(index);
                },
                childCount: dataRepository.dataList.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
