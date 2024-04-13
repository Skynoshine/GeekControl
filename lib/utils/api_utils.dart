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

class TenorApiUtils {
  static final uri = dotenv.env['URL_TENOR_API'];
  static final tenorKey = dotenv.env['KEY_TENOR_API'];
  static final clientKey = dotenv.env['CLIENT_KEY_TENOR_API'];
  static final urlSearch = dotenv.env['URL_SEARCH_TENOR_API'];

  static Uri basicSearch(String search) {
    return Uri.parse("$urlSearch$search&$tenorKey$clientKey");
  }

  static Uri advancedSearch(String search) {
    return Uri.parse(urlSearch! + search + tenorKey! + clientKey!);
  }

  static Uri autoComplete(String search) {
    return Uri.parse("${uri}autocomplete?$tenorKey$clientKey&q=$search");
  }
}
