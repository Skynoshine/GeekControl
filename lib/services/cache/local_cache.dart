import 'dart:convert';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:logger/logger.dart';
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
    List<String> cacheList = prefs.getStringList(key) ?? [];

    final String objectString = object.toString();

    cacheList.add(objectString);

    await prefs.setStringList(key, cacheList);
  }

  Future<void> remove(String title) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(CacheKeys.articles.name);

    if (cachedStrings == null) return;

    List<dynamic> cacheList = [];

    try {
      cacheList = cachedStrings.map((item) => json.decode(item)).toList();
    } catch (e) {
      return;
    }

    cacheList.removeWhere((item) => item['title'] == title);

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

  Future<List<dynamic>> get({required String key}) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? cachedStrings = prefs.getStringList(key);

    if (cachedStrings == null || cachedStrings.isEmpty) {
      return [];
    }

    List<dynamic> cacheList = [];
    Logger().d('cachedStrings: $cachedStrings');
    try {
      cacheList = cachedStrings.map((item) => json.decode(item)).toList();
    } catch (e) {
      return [];
    }
    return cacheList;
  }
}
