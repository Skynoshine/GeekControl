import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';
import 'package:geekcontrol/services/anilist/entities/rates_entity.dart';
import 'package:geekcontrol/services/anilist/repository/anilist_repository.dart';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:geekcontrol/services/cache/local_cache.dart';

class AnilistController {
  final AnilistRepository _repository = AnilistRepository();
  final LocalCache _localCache = LocalCache();

  Future<List<ReleasesAnilistEntity>> getReleasesAnimes() async {
    return await _repository.getReleasesAnimes();
  }

  Future<List<MangasRates>> getRates() async {
    final rates = await _repository.getRateds();
    rates.sort((a, b) => b.meanScore.compareTo(a.meanScore));
    return rates;
  }

  Future<List<MangasRates>> ratesCache() async {
    final cache = await _localCache.get(CacheKeys.rates.key);
    final updateCache = await _localCache.updateCache(CacheKeys.rates.key, 30);

    if (cache != null && !updateCache) {
      List<dynamic> content = cache as List<dynamic>;
      return content.map((e) => MangasRates.fromMap(e)).toList();
    } else {
      final rates = await getRates();
      List<Map<String, dynamic>> ratesMap =
          rates.map((rate) => rate.toMap()).toList();
      await _localCache.put(CacheKeys.rates.key, ratesMap);
      return rates;
    }
  }
}
