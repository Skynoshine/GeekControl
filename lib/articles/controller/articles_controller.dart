import 'package:geekcontrol/articles/entities/noticie_entity.dart';
import 'package:geekcontrol/articles/webscraper/articles_scraper.dart';

class ArticlesController {
  final ArticlesScraper _articlesScraper = ArticlesScraper();

  Future<List<ArticlesEntity>> fetchNews(Uri url) async {
    try {
      // Scraping inicial para obter a lista de artigos
      List<ArticlesEntity> newsList = await _articlesScraper.scrapeNews(url);

      // Listagem dos detalhes dos artigos para cada artigo na lista
      List<Future<ArticlesEntity>> detailedArticlesFutures = [];
      for (var article in newsList) {
        detailedArticlesFutures.add(fetchArticleDetails(article.url, article));
      }

      // Aguarde todas as operações de scraping dos detalhes dos artigos
      List<ArticlesEntity> updatedNewsList = await Future.wait(detailedArticlesFutures);

      return updatedNewsList;
    } catch (e) {
      print('Error fetching news: $e');
      return [];
    }
  }

  Future<ArticlesEntity> fetchArticleDetails(String articleUrl, ArticlesEntity originalArticle) async {
    try {
      // Scraping dos detalhes do artigo usando a URL fornecida
      ArticlesEntity? detailedArticle = await _articlesScraper.scrapeArticleDetails(articleUrl, originalArticle);

      if (detailedArticle.imageUrl != null) {
        return detailedArticle;
      } else {
        // Se os detalhes não puderem ser obtidos, retorne o artigo original
        return originalArticle;
      }
    } catch (e) {
      print('Error fetching article details: $e');
      // Em caso de erro, retorne o artigo original
      return originalArticle;
    }
  }
}
