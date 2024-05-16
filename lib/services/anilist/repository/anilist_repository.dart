import 'dart:convert';
import '../entities/manga_anilist_entity.dart';
import '../entities/releases_anilist_entity.dart';
import '../queries/anilist_query.dart';
import '../../../core/utils/api_utils.dart';

class AnilistRepository {
  Future<List<dynamic>> fetchAllData() async {
    final releases = getReleasesAnimes();
    final anilist = searchManga(title: 'Overlord');
    return Future.wait([releases, anilist]);
  }

  Future<AnilistEntity> _getAbrangeResponse({required String title}) async {
    final response = await AnilistUtils.basicResponse(
      title: title,
      query: Query.abrangeQuery(title: title),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return AnilistEntity.toEntity(jsonResponse);
    } else {
      return AnilistEntity.empty();
    }
  }

  Future<AnilistEntity> _getData({required String title}) async {
    final entity = await _getAbrangeResponse(title: title);
    return entity;
  }

  Future<AnilistEntity> searchManga({required String title}) async {
    await getReleasesAnimes();
    return await _getData(title: title);
  }

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    final response = await AnilistUtils.basicResponse(
      query: Query.releasesQuery(''),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ReleasesAnilistEntity.toEntityList(jsonResponse);
    } else {
      return [ReleasesAnilistEntity.empty()];
    }
  }
}
