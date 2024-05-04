import 'package:geekcontrol/articles/entities/noticie_entity.dart';
import 'package:geekcontrol/articles/webscraper/articles_scraper.dart';
import 'package:geekcontrol/database/database_controller.dart';
import 'package:geekcontrol/utils/api_utils.dart';

class ArticlesController {
  final ArticlesScraper _articlesScraper = ArticlesScraper();
  final DatabaseController _db = DatabaseController();

  Future<List<ArticlesEntity>> fetchNews() async {
    try {
      final List<ArticlesEntity> articles =
          await _articlesScraper.scrapeNews(IntoxiUtils.uri);

      await _insertNewArticlesToCache(articles);
      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<void> _insertNewArticlesToCache(List<ArticlesEntity> articles) async {
    try {
      for (var article in articles) {
        bool existsInCache = await _db.checkDoubleContent(
            find: 'title', findObject: article.title);

        if (!existsInCache) {
          Map<String, dynamic> articleMap = article.toMap();

          // Insert article into cache
          await _db.insert(articleMap);
        }
      }
    } catch (e) {
      throw Exception('Error inserting articles into cache: $e');
    }
  }

  Future<List<ArticlesEntity>> getNewsCache({required int quantity}) async {
    try {
      final List<Map<String, dynamic>> articlesCache = await _db.get(quantity);
      List<ArticlesEntity> articles = articlesCache
          .map((articleMap) => ArticlesEntity.fromMap(articleMap))
          .toList();
      return articles;
    } catch (e) {
      throw Exception('Error getting news from cache: $e');
    }
  }

  Future<ArticlesEntity> fetchArticleDetails(
      String articleUrl, ArticlesEntity originalArticle) async {
    try {
      await fetchNews();
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
