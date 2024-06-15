import 'package:flutter/material.dart';

class Utils {
  final messengerKey = GlobalKey<ScaffoldMessengerState>();
  static showSnackBar(String? text) {
    if (text == null) return;
//final messengerKey = GlobalKey<ScaffoldMessengerState>();
    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red[200],
    );

    // messengerKey.currentState!
    //   ..removeCurrentSnackBar()
    //   ..showSnackBar(snackBar);
  }
}
