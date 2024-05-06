import 'dart:convert';
import 'package:geekcontrol/services/cache/entity/articles_cache_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  static const String cacheKey = 'local-cache';

  Future<void> insert(ArticlesCacheEntity data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cacheList = prefs.getStringList(cacheKey) ?? [];
    cacheList.add(json.encode(data.toMap()));
    await prefs.setStringList(cacheKey, cacheList);
  }

  Future<void> remove(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(LocalCache.cacheKey);

    if (cachedStrings == null) return;

    List cacheList = cachedStrings.map((item) => json.decode(item)).toList();

    cacheList.removeWhere((item) => item['value'] == title);

    List<String> updatedCachedStrings =
        cacheList.map((item) => json.encode(item)).toList();

    await prefs.setStringList(LocalCache.cacheKey, updatedCachedStrings);
  }

  Future clearCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(cacheKey);

    if (cachedStrings == null) return;

    await prefs.clear();
  }
  
  Future<List> get({required String? key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(key ?? cacheKey);
    if (cachedStrings == null || cachedStrings.isEmpty) {
      return [];
    }
    List cacheList = cachedStrings.map((item) => json.decode(item)).toList();

    return cacheList;
  }
}
