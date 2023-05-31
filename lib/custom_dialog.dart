import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomDialog {
  static void showJailBrokenAlertDialog(
    BuildContext context,
    String title,
    String content,
    String appVersion
  ) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              color: Colors.black,
            ),
          ),
          content: Text(
            content + appVersion,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14.0,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    Platform.isAndroid
                        ? SystemChannels.platform
                            .invokeMethod<void>('SystemNavigator.pop')
                        : exit(0);
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  )),
            )
          ],
        );
      },
    );
  }
}
