import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';
import 'package:geekcontrol/services/anilist/repository/anilist_repository.dart';

class AnilistController {
  final AnilistRepository _repository = AnilistRepository();

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    final data = [await _repository.getReleasesAnimes()];
    return data;
  }
}
