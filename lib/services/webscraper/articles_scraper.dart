import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class ArticlesScraper {
  Future<List<ArticlesEntity>> scrapeNews() async {
    try {
      var response = await http.get(IntoxiUtils.uri);

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        var articles = document.querySelectorAll('article');

        List<Future<ArticlesEntity>> articleDetailsFutures = [];
        for (var articleElement in articles) {
          var article = parseArticle(articleElement);
          if (article != null) {
            articleDetailsFutures
                .add(scrapeArticleDetails(article.url, article));
          }
        }
        return await Future.wait(articleDetailsFutures);
      } else {
        throw Exception('Failed to load page: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error scraping news: $e');
    }
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
          imageUrl = originalNewsEntity.imageUrl ?? '';
        }

        return ArticlesEntity(
          title: title,
          author: author,
          date: date,
          content: content,
          imageUrl: imageUrl,
          sourceUrl: articleUrl,
          category: originalNewsEntity.category,
          url: originalNewsEntity.url,
          createdAt: originalNewsEntity.createdAt,
          updatedAt: DateTime.now(),
        );
      } else {
        throw Exception(
            'Failed to load article details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error scraping article details: $e');
    }
  }

  ArticlesEntity? parseArticle(Element article) {
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
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return null;
  }
}
