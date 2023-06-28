// ignore_for_file: file_names

import 'dart:io';

class Sizes {
  static double sm = Platform.isAndroid || Platform.isIOS ? 10 : 12;
  static double md = Platform.isAndroid || Platform.isIOS ? 12:14;
  static double lg = Platform.isAndroid || Platform.isIOS ? 14:16;
  static double xl =Platform.isAndroid || Platform.isIOS ? 16: 18;
  static double xxl =Platform.isAndroid || Platform.isIOS ? 18: 20;
  static double headings =Platform.isAndroid || Platform.isIOS ? 22:28;
  static double mainHeadings = Platform.isAndroid || Platform.isIOS ? 26:36;
}
