import 'package:geekcontrol/services/cache/entity/articles_cache_entity.dart';
import 'package:geekcontrol/services/cache/local_cache.dart';

class LocalCacheController {
  final LocalCache _cache = LocalCache();

  Future<void> insert(dynamic value, bool read, int quantity) {
    final ArticlesCacheEntity data = ArticlesCacheEntity(
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      read: read,
      key: LocalCache.cacheKey,
      value: value ?? '',
      quantity: quantity,
    );
    return _cache.insert(data);
  }

  Future<void> remove(String param) {
    return _cache.remove(param);
  }

  Future<void> clearCache() {
    return _cache.clearCache();
  }

  Future<List> get() {
    return _cache.get(key: null);
  }
}
