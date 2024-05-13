import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/logger.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/services/sites/mangas_news/webscraper/all_articles.dart';
import 'package:geekcontrol/services/sites/intoxi_animes/webscraper/intoxi_articles_scraper.dart';
import 'package:logger/logger.dart';

class ArticlesController extends ChangeNotifier {
  final IntoxiArticles _intoxi = IntoxiArticles();
  final MangaNewsAllArticles _animewsNews = MangaNewsAllArticles();
  Future<List<ArticlesEntity>> articles = Future.value([]);
  int currenctIndex = 0;

  Future<void> changedSite(SitesEnum site) async {
    if (SitesEnum.animesNew.key == site.key && currenctIndex != 1) {
      articles = _animewsNews.getNewsScrap();
      currenctIndex = 1;
    }
    if (SitesEnum.intoxi.key == site.key && currenctIndex != 2) {
      articles = _fetchNews();
      currenctIndex = 2;
    }
    notifyListeners();
  }

  Future<List<ArticlesEntity>> _fetchNews() async {
    try {
      Loggers.fluxControl(_fetchNews, null);

      final Future<List<ArticlesEntity>> articles = _intoxi.scrapeAllNews();

      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  bool loadMore(bool load) {
    return load;
  }

  Future<List<ArticlesEntity>> bannerNews() async {
    final intoxiArticles = await _intoxi.scrapeLimitedNews(5);
    final animesnews = await _animewsNews.getNewsScrap();

    return [...intoxiArticles, ...animesnews];
  }

  Future<ArticlesEntity> fetchArticleDetails(
      String articleUrl, ArticlesEntity originalArticle, String current) async {
    Logger().i(articleUrl);
    try {
      if (current == SitesEnum.animesNew.name) {
        return await _animewsNews.getArticleDetailsScrape(
            articleUrl, originalArticle);
      }
      if (current == SitesEnum.intoxi.name) {
        return await _intoxi.scrapeArticleDetails(articleUrl, originalArticle);
      }
      notifyListeners();
      return originalArticle;
    } catch (e) {
      throw Exception('Error fetching article details: $e');
    }
  }
}
