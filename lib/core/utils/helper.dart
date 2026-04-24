import 'dart:convert';

import 'package:flutter/foundation.dart';

class Helper {

  static void printWrapped(String text){
    var decoded = json.decode(text);
    var encoder = JsonEncoder.withIndent('  '); // Indent 2 spaces
    if(kDebugMode){
      print("\x1B[31mResponse Body: ${encoder.convert(decoded)}");
    }
  }

}