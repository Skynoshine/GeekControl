import '../../../core/utils/date_time.dart';
import '../entities/releases_anilist_entity.dart';
import '../repository/anilist_repository.dart';
import '../../cache/controller/local_cache_controller.dart';

class AnilistController {
  final DateTimeUtil dateTimeUtil = DateTimeUtil();
  final AnilistRepository _repository = AnilistRepository();
  final LocalCacheController localCache = LocalCacheController();

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    final data = await _repository.getReleasesAnimes();
    return data;
  }
}
