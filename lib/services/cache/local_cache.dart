import 'dart:convert';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  Future<void> insertEntity(dynamic data, String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> cacheList = prefs.getStringList(CacheKeys.articles.name) ?? [];
    cacheList.add(json.encode(data.toMap()));
    await prefs.setStringList(CacheKeys.articles.name, cacheList);
  }

  Future<void> insertReader(String key, dynamic object) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<String> cacheList =
        prefs.getStringList(CacheKeys.articles.name) ?? [];

    cacheList.add(object);
    await prefs.setStringList(key, cacheList);
  }

  Future<void> remove(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(CacheKeys.articles.name);

    if (cachedStrings == null) return;

    List cacheList = cachedStrings.map((item) => json.decode(item)).toList();

    cacheList.removeWhere((item) => item['value'] == title);

    List<String> updatedCachedStrings =
        cacheList.map((item) => json.encode(item)).toList();

    await prefs.setStringList(CacheKeys.articles.name, updatedCachedStrings);
  }

  Future clearCache() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(CacheKeys.articles.name);

    if (cachedStrings == null) return;

    await prefs.clear();
  }

  Future<List> get({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings =
        prefs.getStringList(key);
    if (cachedStrings == null || cachedStrings.isEmpty) {
      return [];
    }
    List cacheList = cachedStrings.map((item) => json.decode(item)).toList();

    return cacheList;
  }
}
