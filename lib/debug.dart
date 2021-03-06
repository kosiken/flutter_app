import 'package:flutter/foundation.dart';

class Debug {
  static final Debug _debug = Debug._internal();

  factory Debug() {
    return _debug;
  }

  Debug._internal();

  static var enabled = true;

  static void log(dynamic message) {
    if (kDebugMode) {
      print('[ APPDEBUG ] $message');
    }
  }
}
