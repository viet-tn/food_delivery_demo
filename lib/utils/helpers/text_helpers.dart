extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String hideLastXChar(int x) {
    if (length <= x) {
      return this;
    }
    String result = '';
    final charList = split('');

    for (int i = 0; i < charList.length; ++i) {
      if (i < charList.length - x) {
        result += charList[i];
      } else {
        result += '*';
      }
    }

    return result;
  }

  String foodCategoryProcessor() {
    return replaceAll('-', ' ').capitalize();
  }

  static String toTime(int seconds) {
    final minutes = seconds ~/ 60;
    if (minutes >= 60) {
      final hours = minutes ~/ 60;
      return '~$hours hour${hours == 1 ? '' : 's'}';
    }
    return '$minutes minute${minutes == 1 ? '' : 's'}';
  }

  static String toKm(int meters) {
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }
}
