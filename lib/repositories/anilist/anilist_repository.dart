import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/repositories/anilist/entities/manga_anilist_entity.dart';

import 'package:myapp/repositories/anilist/queries/anilist_query.dart';
import 'package:myapp/core/library/hitagi_cup/utils.dart';

class AnilistRepository {
  Future _getAnilistResponse({required String title}) async {
    final queryBody = {'query': Query.anilistQuery(title: title)};

    final response = await http.post(Uri.parse('https://graphql.anilist.co'),
        headers: Utils.headers, body: jsonEncode(queryBody));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return AnilistEntity.toEntity(jsonResponse);
    } else {
      return response.body;
    }
  }

  Future<AnilistEntity> _anilistData({required String title}) async {
    final entity = await _getAnilistResponse(title: title);
    return entity;
  }

  searchManga({required String title}) async {
    return await _anilistData(title: title);
  }
}
