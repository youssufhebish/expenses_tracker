import 'package:flutter/foundation.dart';

class SuperLogger {
  static PrintColor defaultColor = PrintColor.normal;

  /// Overriding debugPrint function to stop print in console in release mode
  static void debugPrintOverride({
    PrintColor printColor = PrintColor.normal,
  }) {
    if (!kDebugMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }
    defaultColor = printColor;
    donePrint('Debug mode is on'.toUpperCase());
  }

  /// Normal print
  static void normalPrint(String text) {
    debugPrint('\x1B[${defaultColor.color}$text\x1B[0m');
  }

  /// Error print
  static void errorPrint(String text) {
    debugPrint('\x1B[31m$text\x1B[0m');
  }

  /// Warning print
  static void warningPrint(String text) {
    debugPrint(
      '\x1B[33m$text\x1B[0m',
      wrapWidth: 10000000,
    );
  }

  /// Note print
  static void notePrint(String text) {
    debugPrint('\x1B[36m$text\x1B[0m', wrapWidth: 10000000);
  }

  /// Conference print
  static void conferencePrint(String text) {
    debugPrint('CONFERENCE => \x1B[36m$text\x1B[0m');
  }

  /// Done print
  static void donePrint(String text) {
    debugPrint('\x1B[32m$text\x1B[0m');
  }
}

/// Enum for colors
enum PrintColor {
  black(color: '30m'),
  red(color: '31m'),
  green(color: '32m'),
  yellow(color: '33m'),
  blue(color: '34m'),
  magenta(color: '35m'),
  cyan(color: '36m'),
  white(color: '37m'),
  normal(color: '0m');

  final String color;
  const PrintColor({required this.color});
}
