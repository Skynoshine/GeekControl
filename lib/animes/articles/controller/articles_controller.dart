import 'package:geekcontrol/core/utils/logger.dart';
import 'package:geekcontrol/services/cache/articles_cache.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/services/cache/controller/local_cache_controller.dart';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:geekcontrol/services/webscraper/articles_scraper.dart';
import 'package:geekcontrol/services/database/database.dart';

class ArticlesController {
  final ArticlesScraper _articlesScraper = ArticlesScraper();
  final LocalCacheController _cacheController = LocalCacheController();
  final Database _db = Database();

  Future<List<ArticlesEntity>> fetchNews() async {
    try {
      Loggers.fluxControl(fetchNews, null);

      final List<ArticlesEntity> articles =
          await _articlesScraper.scrapeAllNews();
      //await _insertNewArticlesToCache(
      //  articles.map((article) => article.toMap()).toList());

      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  bool loadMore(bool load) {
    return load;
  }

  Future<List<ArticlesEntity>> getArticlesCache({required int quantity}) {
    Loggers.fluxControl(getAllArticlesCache, null);

    return ArticlesCacheDB().getArticlesCache(quantity: quantity, db: _db);
  }

  Future<bool> _lastUpdate() async {
    DateTime cutOffDate = DateTime.now().subtract(const Duration(hours: 1));
    DateTime lastUpdate = await _db.getLastUpdate();

    int differenceInMinutes = cutOffDate.difference(lastUpdate).inMinutes;
    Loggers.fluxControl(_lastUpdate, 'Diferença: $differenceInMinutes');
    return differenceInMinutes > 60;
  }

  Future<List<ArticlesEntity>> getAllArticlesCache() async {
    Loggers.fluxControl(getAllArticlesCache, null);
    //return ArticlesCacheDB().getAllArticles(db: _db);
    return fetchNews();
  }

  Future<void> _insertNewArticlesToCache(
      List<Map<String, dynamic>> articles) async {
    try {
      List<String> titlesToCheck =
          articles.map((article) => article['title'] as String).toList();

      List existingTitles = await _db.checkExistingTitles(titlesToCheck);

      for (var article in articles) {
        if (!existingTitles.contains(article['title'])) {
          await _db.insert(article);
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

  void loadCacheReads(
      int newsCount, int newsViewedCount, List<String> readTitles) async {
    final cachedItems =
        await _cacheController.get(key: CacheKeys.articles.name);
    readTitles = cachedItems.map<String>((item) => item['value']).toList();

    for (var item in cachedItems) {
      int quantity = item['quantity'];
      newsCount = quantity;
    }

    newsViewedCount = readTitles.length;
  }
}
