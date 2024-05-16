import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class AnilistUtils {
  static final Map<String, String> headers = {
    'Content-Type': 'application/json'
  };

  static final uri = Uri.parse(dotenv.env['ANILIST_URL'].toString());

  static Future<http.Response> basicResponse(
      {String? title, required String query}) async {
    final queryBody = {'query': query};
    final response = await http.post(AnilistUtils.uri,
        headers: headers, body: jsonEncode(queryBody));
    return response;
  }
}

class IntoxiUtils {
  static final uri = Uri.parse(dotenv.env['INTOXI_URL'].toString());
  static final uriStr = dotenv.env['INTOXI_URL'].toString();
  static final spoilers = Uri.parse(dotenv.env['SPOILERS_URL'].toString());
  static final spoilersStr = dotenv.env['SPOILERS_URL'].toString();
}

class AnimesNewUtils {
  static final uri = Uri.parse(dotenv.env['ANIMESNEW_URL'].toString());
  static final uriStr = dotenv.env['ANIMESNEW_URL'].toString();
}

class OtakuPt {
  static final uri = Uri.parse(dotenv.env['OTAKU_PT_URL'].toString());
  static final uriStr = dotenv.env['OTAKU_PT_URL'].toString();
}

class Scrap {
  static String xPathToSelect(String url) {
    if (url.contains('/')) url = url.replaceFirst('/', '');
    if (url.contains('/')) url = url.replaceAll('/', ' > ');
    for (var i = 0; i < 30; i++) {
      if (url.contains('[$i]')) url = url.replaceAll('[$i]', '');
    }

    return url;
  }
}
