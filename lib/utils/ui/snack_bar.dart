import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

import '../../app.dart';

class FSnackBar {
  static void showSnackBar(
    String title,
    String message, {
    ContentType? contentType,
  }) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType ?? ContentType.failure,
      ),
    );

    MyApp.messengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static void showBanner(
    String title,
    String message, {
    ContentType? contentType,
  }) {
    final materialBanner = MaterialBanner(
      elevation: 0,
      backgroundColor: Colors.transparent,
      forceActionsBelow: true,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType ?? ContentType.failure,
        inMaterialBanner: true,
      ),
      actions: [
        IconButton(
            onPressed: () =>
                MyApp.messengerKey.currentState!.hideCurrentMaterialBanner(),
            icon: const Icon(Icons.close)),
      ],
    );

    MyApp.messengerKey.currentState!
      ..hideCurrentMaterialBanner()
      ..showMaterialBanner(materialBanner);
  }
}
