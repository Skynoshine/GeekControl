import 'dart:convert';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';
import 'package:geekcontrol/services/anilist/entities/rates_entity.dart';
import 'package:geekcontrol/services/anilist/queries/anilist_query.dart';
import 'package:logger/logger.dart';

class AnilistRepository {
  Future<List<MangasRates>> getRateds() async {
    final response =
        await AnilistUtils.basicResponse(query: Query.ratedsQuery());

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final mangas = MangasRates.toEntityList(jsonResponse);
      return mangas;
    } else {
      Logger().e('Error: ${response.statusCode}');
      return [MangasRates.empty()];
    }
  }

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    final response = await AnilistUtils.basicResponse(
      query: Query.releasesQuery(''),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return ReleasesAnilistEntity.toEntityList(jsonResponse);
    }
    return [ReleasesAnilistEntity.empty()];
  }
}
