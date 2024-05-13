import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/services/sites/mangas_news/webscraper/all_articles.dart';
import 'package:geekcontrol/services/sites/mangas_news/webscraper/manga_articles.dart';

class MangaNewsController {
  Future<List<ArticlesEntity>> getMangasNews() async {
    return await AnimesnewMangasArticles().getMangasScrap();
  }

  Future<ArticlesEntity> getNewsDetails(
      ArticlesEntity entity, String url) async {
    return await MangaNewsAllArticles().getArticleDetailsScrape(url, entity);
  }

  Future<List<ArticlesEntity>> getAllNews() async {
    return await MangaNewsAllArticles().getNewsScrap();
  }

  Future<List<ArticlesEntity>> getLimitedNews({required int quantity}) async {
    return await MangaNewsAllArticles().scrapeLimitedNewsList(quantity);
  }
}
