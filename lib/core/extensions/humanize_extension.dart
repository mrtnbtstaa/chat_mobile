extension HumanizeExtension on String{
  String humanize() => length != 0 ? replaceFirst("_", " ") : "";
}