import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:myapp/repositories/tenor_images/entities/tenor_entity.dart';

class TenorRepository {
  Future<TenorEntity> _getTenorResponse(String searchTerm) async {
    final apiKey = dotenv.env['KEY_TENOR_API'];
    final clientKey = dotenv.env['CLIENT_KEY_TENOR_API'];
    final url = dotenv.env['URL_TENOR_API'];
    final uri = Uri.parse(url! + searchTerm + apiKey! + clientKey!);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return TenorEntity.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to Tenor response');
    }
  }

  Future<String> getGifUrl(String searchTerm) async {
    final response = await _getTenorResponse(searchTerm);
    return response.url;
  }
}
