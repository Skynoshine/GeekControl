import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Utils {
  static String maxCharacters(int maxCharacters, {required String text}) {
    if (text.length > maxCharacters) {
      return '${text.substring(0, maxCharacters)}...';
    }
    return text;
  }

  static String timeFromMSeconds(int dateTimestamp) {
    initializeDateFormatting('pt_BR', null);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(dateTimestamp * 1000);
    return DateFormat.yMMMMd('pt_BR').format(dateTime);
  }
}
