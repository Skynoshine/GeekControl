import 'package:geekcontrol/services/cache/entity/articles_cache_entity.dart';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:geekcontrol/services/cache/local_cache.dart';

class LocalCacheController {
  final LocalCache _cache = LocalCache();

  Future<void> insertEntity(dynamic value, bool read, int quantity) {
    final ArticlesCacheEntity data = ArticlesCacheEntity(
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
      read: read,
      key: CacheKeys.articles.name,
      value: value ?? '',
      quantity: quantity,
    );
    return _cache.insertEntity(data, CacheKeys.articles.name);
  }

  Future<void> insertReader(dynamic data,{required String key}) async {
    return _cache.insertReader(data, key);
  }

  Future<void> remove(String param) {
    return _cache.remove(param);
  }

  Future<void> clearCache() {
    return _cache.clearCache();
  }

  Future<List> get({required String key}) {
    return _cache.get(key: key);
  }
}
