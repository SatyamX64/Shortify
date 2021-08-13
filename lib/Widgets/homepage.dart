import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:shortify/Models/url.dart';
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
  final FocusScopeNode _node = FocusScopeNode();
  @override
  void dispose() {
    _node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();
    final networkLoader = NetworkLoader();
    final urlController = TextEditingController();
    final titleController = TextEditingController();
    final customController = TextEditingController();

    Function onSubmit = () async {
      var connectivityResult = await (Connectivity()
          .checkConnectivity()); // Checks If Internet is Available
      if (_formKey.currentState.validate() &&
          connectivityResult != ConnectivityResult.none) {
        setState(() {
          _loading = true;
        });
        Response response = await networkLoader.shortenURL(
            url: urlController.text.contains('https')
                ? urlController.text
                : 'https://' + urlController.text,
            customCode: customController.text);
        setState(() {
          _loading = false;
        });
        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          int status = data['url']['status'];
          if (status == 7) {
            //Status 7 Means Success in this API Call
            var box = Hive.box('urls');
            box.add(
              URL(
                longURL: data['url']['fullLink'],
                shortURL: data['url']['shortLink'],
                title: titleController.text.length < 1
                    ? data['url']['title']
                    : titleController.text,
              ),
            );
          } else
            errorBox(context: context, status: status);
        } else
          errorBox(context: context, status: 8);
      } else if (connectivityResult == ConnectivityResult.none) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: kPurple,
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
    };
    return SafeArea(
      child: Form(
        key: _formKey,
        child: FocusScope(
          node: _node,
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                centerTitle: true,
                backgroundColor: kPurple,
                title: Text(
                  'Shortify',
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: size.width / 12,
                      fontFamily: 'Purple'),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    SizedBox(height: size.height / 72),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 36),
                      child: TextFormField(
                        controller: urlController,
                        enabled: !_loading,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: _node.nextFocus,
                        decoration: InputDecoration(hintText: 'Enter Long URL'),
                        validator: (value) =>
                            isURL(value) ? null : 'Invalid URL',
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
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _node.nextFocus,
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
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) async {
                            await onSubmit();
                          },
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
                            ? ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: kPurple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                child: LoadingIndicator(
                                  indicatorType: Indicator.ballPulse,
                                  color: Colors.white,
                                ),
                                onPressed:
                                    () {}, // Pressing Button while Loading should not do anything
                              )
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: kPurple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                child: Text(
                                  'Create Short URL',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: size.width / 24,
                                  ),
                                ),
                                onPressed: onSubmit,
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
                      color: kPurple,
                      fontWeight: FontWeight.w900,
                      fontSize: size.height / 36),
                ),
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              ),
              _buildListView(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildListView() {
  return ValueListenableBuilder(
    valueListenable: Hive.box('urls').listenable(),
    builder: (context, box, _) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final url = box.getAt(index) as URL;
            return URLCard(url);
          },
          childCount: box.length,
        ),
      );
    },
  );
}
