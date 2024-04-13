import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Utils {
  static String timeFromMSeconds(int dateTimestamp) {
    initializeDateFormatting('pt_BR', null);
    DateTime dateTime =
        DateTime.fromMillisecondsSinceEpoch(dateTimestamp * 1000);
    return DateFormat.yMMMMd('pt_BR').format(dateTime);
  }
}
