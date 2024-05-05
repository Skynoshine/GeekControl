import 'package:geekcontrol/core/utils/logger.dart';
import 'package:geekcontrol/services/cache/articles_cache.dart';
import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/services/cache/controller/local_cache_controller.dart';
import 'package:geekcontrol/services/webscraper/articles_scraper.dart';
import 'package:geekcontrol/services/database/database.dart';

class ArticlesController {
  final ArticlesScraper _articlesScraper = ArticlesScraper();
  final LocalCacheController _cacheController = LocalCacheController();
  final Database _db = Database();

  Future<List<ArticlesEntity>> fetchNews() async {
    try {
      Loggers.fluxControl(fetchNews, null);

      final List<ArticlesEntity> articles = await _articlesScraper.scrapeNews();
      await _insertNewArticlesToCache(articles);

      Loggers.fluxControl(fetchNews, 'Fechando');
      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  Future<List<ArticlesEntity>> getArticlesCache({required int quantity}) {
    Loggers.fluxControl(getAllArticlesCache, null);

    return ArticlesCacheDB().getArticlesCache(quantity: quantity, db: _db);
  }

  Future<bool> _lastUpdate() async {
    DateTime cutOffDate = DateTime.now().subtract(const Duration(minutes: 60));
    DateTime lastUpdate = await _db.getLastUpdate();
    int differenceInMinutes = cutOffDate.difference(lastUpdate).inMinutes;
    Loggers.fluxControl(_lastUpdate, 'Diferença: $differenceInMinutes');
    return differenceInMinutes < 60;
  }

  Future<List<ArticlesEntity>> getAllArticlesCache() async {
    Loggers.fluxControl(getAllArticlesCache, null);

    if (await _lastUpdate() == true) {
      return await fetchNews();
    }
    return ArticlesCacheDB().getAllArticles(db: _db);
  }

 
  Future<List<ArticlesEntity>> getArticlesFromCache() async {
    List cachedItems = await _cacheController.get();
    List<ArticlesEntity> articles = cachedItems.map((item) {
      return ArticlesEntity.fromMap(item);
    }).toList();
    Loggers.fluxControl(getArticlesFromCache, '$articles');
    return articles;
  }

  Future<void> _insertNewArticlesToCache(List<ArticlesEntity> articles) async {
    Loggers.fluxControl(_insertNewArticlesToCache, null);

    if (await _lastUpdate()) {
      return;
    }

    try {
      Map<String, dynamic> articleMap = {};

      for (var article in articles) {
        bool existsInCache = await _db.checkDoubleContent(
            find: 'title', findObject: article.title);

        if (!existsInCache) {
          articleMap = article.toMap();
        }
      }
      Loggers.fluxControl(_insertNewArticlesToCache, 'Fechando');
      return await _db.insert(articleMap);
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

    loadCacheReads(int newsCount, int newsViewedCount, List<String> readTitles) async {
    final cachedItems = await _cacheController.get();
      readTitles = cachedItems.map<String>((item) => item['value']).toList();

      for (var item in cachedItems) {
        int quantity = item['quantity'];
        newsCount = quantity;
      }

      newsViewedCount = readTitles.length;
    }
  }
