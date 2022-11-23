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
}
