
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

Future<void> errorBox({context, int status}) async {
  String message;
  if (status == 1)
    message = 'It is already pretty short';
  else if (status == 2)
    message = 'The Entered Link is not a Link';
  else if (status == 3)
    message = 'The Preferred Link name is already taken';
  else if (status == 4)
    message = 'Invalid API key';
  else if (status == 5)
    message = 'The Link includes Invalid Characters';
  else if (status == 6)
    message = 'The Link is from a blocked Domain';
  else if (status == 8) message = 'Something went terribly Wrong';

  return AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.ERROR,
      body: Center(
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      btnOkOnPress: () {})
    ..show();
}
