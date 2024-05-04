import 'package:geekcontrol/articles/entities/noticie_entity.dart';
import 'package:geekcontrol/database/database_controller.dart';

class ArticlesCache {
  Future<List<ArticlesEntity>> getArticlesCache(
      {required quantity, required DatabaseController db}) async {
    try {
      final List<Map<String, dynamic>> articlesCache = await db.get(quantity);
      List<ArticlesEntity> articles = articlesCache
          .map((articleMap) => ArticlesEntity.fromMap(articleMap))
          .toList();
      return articles;
    } catch (e) {
      throw Exception('Error getting news from cache: $e');
    }
  }

  Future<List<ArticlesEntity>> getAllArticles(
      {required DatabaseController db}) async {
    try {
      final List<Map<String, dynamic>> articlesCache = await db.getAll();
      List<ArticlesEntity> articles = articlesCache
          .map((articleMap) => ArticlesEntity.fromMap(articleMap))
          .toList();
      return articles;
    } catch (e) {
      throw Exception('Error getting news from cache: $e');
    }
  }
}
