import 'package:geekcontrol/services/cache/articles_cache.dart';
import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/services/webscraper/articles_scraper.dart';
import 'package:geekcontrol/services/database/database.dart';

class ArticlesController {
  final ArticlesScraper _articlesScraper = ArticlesScraper();
  final Database _db = Database();

  Future<List<ArticlesEntity>> fetchNews() async {
    try {
      final List<ArticlesEntity> articles = await _articlesScraper.scrapeNews();

      await _insertNewArticlesToCache(articles);
      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<ArticlesEntity>> getArticlesCache({required int quantity}) {
    return ArticlesCacheDB().getArticlesCache(quantity: quantity, db: _db);
  }

  Future<List<ArticlesEntity>> getAllArticlesCache() async {
    DateTime cutOffDate = DateTime.now().subtract(const Duration(minutes: 60));
    DateTime lastUpdate = await _db.getLastUpdate();
    int differenceInMinutes = cutOffDate.difference(lastUpdate).inMinutes;
    if (differenceInMinutes > 60) {
      return await fetchNews();
    }
    return ArticlesCacheDB().getAllArticles(db: _db);
  }

  Future<void> _insertNewArticlesToCache(List<ArticlesEntity> articles) async {
    try {
      for (var article in articles) {
        bool existsInCache = await _db.checkDoubleContent(
            find: 'title', findObject: article.title);

        if (!existsInCache) {
          Map<String, dynamic> articleMap = article.toMap();
          await _db.insert(articleMap);
        }
      }
    } catch (e) {
      throw Exception('Error inserting articles into cache: $e');
    }
  }

  Future<ArticlesEntity> fetchArticleDetails(
      String articleUrl, ArticlesEntity originalArticle) async {
    try {
      ArticlesEntity detailedArticle = await _articlesScraper
          .scrapeArticleDetails(articleUrl, originalArticle);

      return detailedArticle.imageUrl != null
          ? detailedArticle
          : originalArticle;
    } catch (e) {
      throw Exception('Error fetching article details: $e');
    }
  }
}
