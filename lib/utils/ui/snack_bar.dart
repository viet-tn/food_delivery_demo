import 'package:flutter/material.dart';

import '../../app.dart';
import '../../constants/ui/text_style.dart';

class FSnackBar {
  static void showSnackBar(String? text, [Color color = Colors.red]) {
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(
        text,
        style: FTextStyles.errorMessage,
      ),
      backgroundColor: color,
    );

    MyApp.messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
