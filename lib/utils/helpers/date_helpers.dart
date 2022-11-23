extension DateTimeExtension on DateTime {
  String get timeString =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
