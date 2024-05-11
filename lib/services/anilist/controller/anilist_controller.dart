import 'package:geekcontrol/core/utils/date_time.dart';
import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';
import 'package:geekcontrol/services/anilist/repository/anilist_repository.dart';
import 'package:geekcontrol/services/cache/controller/local_cache_controller.dart';

class AnilistController {
  final DateTimeUtil dateTimeUtil = DateTimeUtil();
  final AnilistRepository _repository = AnilistRepository();
  final LocalCacheController localCache = LocalCacheController();

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    final data = await _repository.getReleasesAnimes();
    return data;
  }
}
