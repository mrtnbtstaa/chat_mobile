extension StringExtension on String {
  String get humanize => length != 0 ? replaceFirst("_", " ") : "";
  String get capitalize => split(' ')
  .where((word) => word.isNotEmpty)
  .map((word) => "${word[0].toUpperCase()}${word.substring(1).toLowerCase()}")
  .join(' ');
  String get firstname => split(' ')
  .where((word) => word.isNotEmpty).first;

}