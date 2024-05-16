import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/sites/animes_united/animes_united_scraper.dart';
import 'package:geekcontrol/services/sites/intoxi_animes/webscraper/intoxi_articles_scraper.dart';
import 'package:geekcontrol/services/sites/mangas_news/webscraper/all_articles.dart';


class ArticlesController extends ChangeNotifier {
  final IntoxiArticles _intoxi = IntoxiArticles();
  final OtakuPT _otakuPt = OtakuPT();
  final MangaNewsAllArticles _animewsNews = MangaNewsAllArticles();
  Future<List<ArticlesEntity>> articles = Future.value([]);
  Future<List<ArticlesEntity>> articlesSearch = Future.value([]);

  int currenctIndex = 0;

  var currentSite = SitesEnum.animesNew;

  Future<List<ArticlesEntity>> intoxiSearch({required String article}) async {
    return await _intoxi.scrapeArticles('${IntoxiUtils.uriStr}?s=$article');
  }

  Future<void> changedSite(SitesEnum site) async {
    if (SitesEnum.animesNew.key == site.key && currenctIndex != 1) {
      articles = _animewsNews.getNewsScrap();
      currenctIndex = 1;
      currentSite = site;
    }
    if (SitesEnum.otakuPt.key == site.key && currenctIndex != 2) {
      articles = _otakuPt.fetchArticles();
      currenctIndex = 2;
      currentSite = site;
    }
    if (SitesEnum.intoxi.key == site.key && currenctIndex != 3) {
      articles = _fetchNews();
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
    if (SitesEnum.intoxi.key == site.key) {
      articlesSearch = intoxiSearch(article: article);
      currenctIndex = 2;
    }
    notifyListeners();
  }

  Future<List<ArticlesEntity>> _fetchNews() async {
    try {
      final Future<List<ArticlesEntity>> articles =
          _intoxi.scrapeArticles(IntoxiUtils.uriStr);

      return articles;
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  bool loadMore(bool load) {
    return load;
  }

  Future<List<ArticlesEntity>> bannerNews() async {
    final otakupt = await _otakuPt.fetchArticles();
    final intoxi = await _intoxi.scrapeArticles(IntoxiUtils.uriStr);

    return [
      ...otakupt.getRange(0, 3),
      ...intoxi.getRange(0, 3),
    ];
  }

  Future<ArticlesEntity> fetchArticleDetails(
      String articleUrl, ArticlesEntity originalArticle, String current) async {
    try {
      if (current == SitesEnum.animesNew.name) {
        return await _animewsNews.getArticleDetailsScrape(
            articleUrl, originalArticle);
      }
      if (current == SitesEnum.otakuPt.name) {
        return await _otakuPt.getArticleDetailsScrape(
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
