import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/cache/keys_enum.dart';
import 'package:geekcontrol/services/cache/local_cache.dart';
import 'package:geekcontrol/services/sites/otakupt/otakupt_scraper.dart';
import 'package:geekcontrol/services/sites/intoxi_animes/webscraper/intoxi_articles_scraper.dart';
import 'package:geekcontrol/services/sites/mangas_news/webscraper/all_articles.dart';

class ArticlesController extends ChangeNotifier {
  final IntoxiArticles _intoxi = IntoxiArticles();
  final OtakuPT _otakuPt = OtakuPT();
  final MangaNews _animewsNews = MangaNews();

  Future<List<ArticlesEntity>> articles = Future.value([]);
  Future<List<ArticlesEntity>> articlesSearch = Future.value([]);
  int currenctIndex = 0;

  final _cache = LocalCache();
  var currentSite = SitesEnum.animesNew;

  Future<void> changedSite(SitesEnum site) async {
    if (SitesEnum.animesNew.key == site.key && currenctIndex != 1) {
      articles = _animewsNews.scrapeArticles();
      currenctIndex = 1;
      currentSite = site;
    }
    if (SitesEnum.otakuPt.key == site.key && currenctIndex != 2) {
      articles = _otakuPt.scrapeArticles();
      currenctIndex = 2;
      currentSite = site;
    }
    if (SitesEnum.intoxi.key == site.key && currenctIndex != 3) {
      articles = _intoxi.scrapeArticles(IntoxiUtils.uriStr);
      currenctIndex = 3;
      currentSite = site;
    }
    notifyListeners();
  }

  Future<void> changedSearchSite(SitesEnum site,
      {required String article}) async {
    if (SitesEnum.animesNew.key == site.key) {
      articlesSearch = _animewsNews.searchArticle(article);
      currenctIndex = 1;
    }
    if (SitesEnum.otakuPt.key == site.key) {
      articlesSearch = _otakuPt.searchArticles(article);
      currenctIndex = 2;
    }
    if (SitesEnum.intoxi.key == site.key) {
      articlesSearch = _intoxi.searchArticles(article: article);
      currenctIndex = 3;
    }
    notifyListeners();
  }

  bool loadMore(bool load) {
    return load;
  }

  Future<List<ArticlesEntity>> bannerNews() async {
    final newsCache = await _cache.get(CacheKeys.articles.key);
    final updateCache = await _cache.updateArticles(CacheKeys.articles.key);

    if (await newsCache != null && !updateCache) {
      List<dynamic> cacheArticles = newsCache as List<dynamic>;

      return cacheArticles.map((json) => ArticlesEntity.fromMap(json)).toList();
    } else {
      final otakupt = await _otakuPt.scrapeArticles();
      final intoxi = await _intoxi.scrapeArticles(IntoxiUtils.uriStr);

      final news = [
        ...otakupt.getRange(0, 3),
        ...intoxi.getRange(0, 3),
      ];
      await _cache.putArticles(CacheKeys.articles.key, news);
      return news;
    }
  }

  Future<ArticlesEntity> fetchArticleDetails(
      String url, ArticlesEntity articles, String current) async {
    try {
      if (current == SitesEnum.animesNew.name) {
        return await _animewsNews.scrapeArticleDetails(url, articles);
      }
      if (current == SitesEnum.otakuPt.name) {
        return await _otakuPt.scrapeArticleDetails(url, articles);
      }
      if (current == SitesEnum.intoxi.name) {
        return await _intoxi.scrapeArticleDetails(url, articles);
      }
      notifyListeners();
      return articles;
    } catch (e) {
      throw Exception('Error fetching article details: $e');
    }
  }

  Future<void> loadReadArticles() async {
    _cache.get(CacheKeys.reads.key);
    notifyListeners();
  }

  Future<void> markAsRead(String title, List<String> readArticles) async {
    if (!readArticles.contains(title)) {
      readArticles.add(title);
      await _cache.put(CacheKeys.reads.key, readArticles);
      notifyListeners();
    }
  }

  Future<bool> isRead(String title, List<String> readArticles) async {
    final reads = await _cache.get(CacheKeys.reads.key);
    return reads.contains(title);
  }

  Future<void> markAsUnread(String title, List<String> readArticles) async {
    if (readArticles.contains(title)) {
      readArticles.remove(title);
      await _cache.put(CacheKeys.reads.key, readArticles);
      notifyListeners();
    }
  }
}
