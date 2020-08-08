import 'package:clipboard_manager/clipboard_manager.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shortify/Analytics/analytics.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shortify/Data/data_repository.dart';


class URLCard extends StatelessWidget {
  final int index;
  URLCard(this.index);
  @override
  Widget build(BuildContext context) {
    final dataRepository = Provider.of<DataRepository>(context);
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width / 360, vertical: size.width / 360),
      child: Slidable(
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.25,
        child: Card(
          child: ListTile(
            title: Text(
              '${dataRepository.dataList[index].title}',
              style: TextStyle(
                  fontSize: size.height / 45, fontWeight: FontWeight.w700),
            ),
            subtitle: Text('${dataRepository.dataList[index].shortURL}'),
            trailing: IconButton(
                icon: Icon(
                  Icons.content_paste,
                  color: Colors.black54,
                ),
                onPressed: () {
                  ClipboardManager.copyToClipBoard(
                          dataRepository.dataList[index].shortURL)
                      .then((result) {
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
                    Scaffold.of(context).showSnackBar(snackBar);
                  });
                }),
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Go to URL',
            color: Colors.blue,
            icon: Icons.open_in_new,
            onTap: () => dataRepository.launchURL(index),
          ),
          IconSlideAction(
            caption: 'Share',
            color: Colors.indigo,
            icon: Icons.share,
            onTap: () {
              final RenderBox box = context.findRenderObject();
              Share.share(
                  '${dataRepository.dataList[index].title} : ${dataRepository.dataList[index].shortURL}',
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
              } else
                Analytics(
                  context: context,
                  url: dataRepository.dataList[index].shortURL,
                )..show();
            },
          ),
          IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => dataRepository.delete(index)),
        ],
      ),
    );
  }
}
