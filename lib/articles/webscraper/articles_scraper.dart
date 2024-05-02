import 'package:geekcontrol/articles/entities/noticie_entity.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class ArticlesScraper {
  Future<List<ArticlesEntity>> scrapeNews(Uri url) async {
    try {
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        var articles = document.querySelectorAll('article');

        List<ArticlesEntity> newsList = _parseArticles(articles);

        // Atualize cada artigo com os detalhes coletados
        List<Future<ArticlesEntity>> articleDetailsFutures = [];
        for (var article in newsList) {
          articleDetailsFutures.add(scrapeArticleDetails(article.url, article));
        }

        // Aguarde todas as operações de scraping dos detalhes dos artigos
        List<ArticlesEntity> updatedNewsList =
            await Future.wait(articleDetailsFutures);

        return updatedNewsList;
      } else {
        throw Exception('Failed to load page: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error scraping news: $e');
    }
  }

  List<ArticlesEntity> _parseArticles(List<Element> articles) {
    List<ArticlesEntity> newsList = [];

    for (var article in articles) {
      try {
        var newsArticle = _parseArticle(article);
        if (newsArticle != null) {
          newsList.add(newsArticle);
        }
      } catch (e) {
        print('Error parsing article: $e');
      }
    }

    return newsList;
  }

  Future<ArticlesEntity> scrapeArticleDetails(
      String articleUrl, ArticlesEntity originalNewsEntity) async {
    try {
      var response = await http.get(Uri.parse(articleUrl));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);

        var title =
            document.querySelector('h1.post-title.entry-title')?.text.trim() ??
                '';
        var author =
            document.querySelector('.post-byline .fn a')?.text.trim() ?? '';
        var date =
            document.querySelector('time.published')?.attributes['datetime'] ??
                '';
        var contentElements = document.querySelectorAll('.entry p');

        var content =
            contentElements.map((element) => element.text.trim()).join('\n');

        var imageUrl = '';
        var imageUrlElement = document.querySelector('.post-thumbnail img');
        if (imageUrlElement != null) {
          imageUrl = imageUrlElement.attributes['src'] ?? '';
        } else {
          // Se a imagem não for encontrada, use a imagem original da ArticlesEntity
          imageUrl = originalNewsEntity.imageUrl!;
        }
        return ArticlesEntity(
          title: title,
          author: author,
          date: date,
          content: content,
          imageUrl: imageUrl,
          sourceUrl: articleUrl,
          category: '',
          url: '',
        );
      } else {
        throw Exception(
            'Falha ao carregar detalhes do artigo: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro ao raspar detalhes do artigo: $e');
    }
  }

  ArticlesEntity? _parseArticle(Element article) {
    var titleElement = article.querySelector('h2.post-title.entry-title a');
    var imageUrlElement = article.querySelector('.post-thumbnail img');
    var dateElement = article.querySelector('time.published');
    var authorElement = article.querySelector('.post-byline .fn a');
    var categoryElement = article.querySelector('.post-category a');
    var contentElement = article.querySelector('.entry p');

    if (titleElement != null &&
        imageUrlElement != null &&
        dateElement != null &&
        authorElement != null &&
        categoryElement != null &&
        contentElement != null) {
      var title = titleElement.text.trim();
      var imageUrl = imageUrlElement.attributes['src'] ?? '';
      var date = dateElement.attributes['datetime'] ?? '';
      var author = authorElement.text.trim();
      var category = categoryElement.text.trim();
      var content = contentElement.text.trim();
      var articleUrl = titleElement.attributes['href'] ?? '';

      return ArticlesEntity(
        title: title,
        imageUrl: imageUrl,
        date: date,
        author: author,
        category: category,
        content: content,
        url: articleUrl,
        sourceUrl: '',
      );
    }

    return null;
  }
}
