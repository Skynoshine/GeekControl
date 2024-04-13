import 'dart:convert';
import 'package:geekcontrol/repositories/tenor_images/entities/tenor_entity.dart';
import 'package:geekcontrol/utils/api_utils.dart';
import 'package:http/http.dart' as http;

class TenorRepository {
  Future<TenorAutoComplete> _getTenorAutoComplete(String searchTerm) async {
    final response = await http.get(TenorApiUtils.autoComplete(searchTerm));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return TenorAutoComplete.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to AutoComplete response');
    }
  }

  Future<TenorEntity> _getTenorResponse(String searchTerm) async {
    final response = await http.get(TenorApiUtils.basicSearch(searchTerm));

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

  Future<List> autoComplete(String searchTerm) async {
    final response = await _getTenorAutoComplete(searchTerm);
    return response.autoComplete;
  }

  advancedSearch(String keyword) {}
}
