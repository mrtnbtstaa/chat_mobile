extension IntExtension on int{

  Duration milliseconds() => Duration(milliseconds: this);
  Duration seconds() => Duration(seconds: this);
  Duration hours() => Duration(hours: this);
  Duration microseconds() => Duration(microseconds: this);
  Duration minutes() => Duration(minutes: this);
  Duration days() => Duration(hours: this);

}