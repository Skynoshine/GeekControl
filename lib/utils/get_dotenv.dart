import 'package:dotenv/dotenv.dart' as dotenv;

class Env {
  static String keyTenorApi() {
    var env = dotenv.DotEnv(includePlatformEnvironment: true)..load();
    env.load();
    final keyTenorApi = env['TENOR_API'];
    return keyTenorApi!;
  }
}
