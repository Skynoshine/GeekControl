import 'package:logger/logger.dart';

class Loggers extends Logger {
  static final Loggers _instance = Loggers._internal();

  factory Loggers() {
    return _instance;
  }

  static void fluxControl(Object method, String? operation) {
    return _instance.d('${operation ?? 'Acesso'} à: $method em: ${DateTime.now()}');
  }

  Loggers._internal();
}
