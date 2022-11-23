import 'dart:convert';
import 'dart:io';

import 'package:flutter/widgets.dart';

class ImageConverter {
  static bool canConvert(String string) {
    /// https://stackoverflow.com/a/8571649
    final base64Pattern =
        RegExp(r'^([A-Za-z0-9+/]{4})*([A-Za-z0-9+/]{3}=|[A-Za-z0-9+/]{2}==)?$');
    return string.contains(base64Pattern);
  }

  static String base64StringFromImage(String imgPath) {
    final bytes = File(imgPath).readAsBytesSync();
    return base64Encode(bytes);
  }

  static Image imageFromBase64String(String base64String,
      [BoxFit fit = BoxFit.fill]) {
    return Image.memory(
      base64Decode(base64String),
      fit: fit,
    );
  }
}
