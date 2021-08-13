import 'package:clipboard/clipboard.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shortify/Analytics/analytics.dart';
import 'package:share/share.dart';
import 'package:shortify/Models/url.dart';
import 'package:shortify/Theme/theme_data.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class URLCard extends StatelessWidget {
  final URL url;
  URLCard(this.url);
  @override
  Widget build(BuildContext context) {
    Future<void> launchURL() async {
      if (await url_launcher.canLaunch(url.shortURL)) {
        await url_launcher.launch(url.shortURL);
      } else {
        throw 'Could not launch ${url.shortURL}';
      }
    }

    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width / 90, vertical: size.width / 360),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 75,
                color: kPurple,
                width: 10,
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    '${url.title}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: size.height / 45,
                        fontWeight: FontWeight.w700),
                  ),
                  subtitle: Text('${url.shortURL}'),
                  trailing: IconButton(
                      icon: Icon(
                        Icons.content_paste,
                        color: Colors.black54,
                      ),
                      onPressed: () {
                        FlutterClipboard.copy(url.shortURL).then((result) {
                          final snackBar = SnackBar(
                            backgroundColor: Colors.blue,
                            content: Text(
                              'Copied to Clipboard',
                              style: TextStyle(
                                  fontFamily: 'Sen',
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Go to URL',
            color: Colors.blue,
            icon: Icons.open_in_new,
            onTap: () => launchURL(),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () {
              final RenderBox box = context.findRenderObject();
              Share.share('${url.title} : ${url.shortURL}',
                  subject: 'URL Shortener',
                  sharePositionOrigin:
                      box.localToGlobal(Offset.zero) & box.size);
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Analytics',
            color: Colors.black45,
            icon: Icons.more_horiz,
            onTap: () async {
              var connectivityResult = await Connectivity().checkConnectivity();
              if (connectivityResult == ConnectivityResult.none) {
                ScaffoldMessenger.of(context).showSnackBar(
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
              } else
                Analytics(
                  context: context,
                  url: url.shortURL,
                )..show();
            },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap: () async {
              await url.delete();
            },
          ),
        ],
      ),
    );
  }
}
