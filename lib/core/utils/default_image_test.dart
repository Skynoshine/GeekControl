import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultImage {
  static String banner = dotenv.env['DEFAULT_BANNER'].toString();
  static String icon = dotenv.env['DEFAULT_ICON'].toString();
}
