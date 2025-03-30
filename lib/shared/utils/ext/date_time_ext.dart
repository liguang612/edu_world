extension DateTimeExt on DateTime {
  String get formattedString => "${day.toString().padLeft(2, '0')}/"
      "${month.toString().padLeft(2, '0')}/"
      "$year";
}
