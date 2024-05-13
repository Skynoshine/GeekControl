import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class IntoxiArticles {
  Future<List<ArticlesEntity>> scrapeAllNews() async {
    Set<ArticlesEntity> allArticles = {};
    final Set<String> processedTitles = {};
    bool hasMoreContent = true;

    while (hasMoreContent && allArticles.length < 12) {
      try {
        var response = await http.get(IntoxiUtils.uri);

        if (response.statusCode == 200) {
          final doc = parser.parse(response.body);
          final articles = doc.querySelectorAll('article');

          if (articles.isEmpty) {
            hasMoreContent = false;
          } else {
            for (var articleElement in articles) {
              var article = _parseArticle(articleElement);

              if (article != null) {
                if (!processedTitles.contains(article.title)) {
                  allArticles.add(article);
                  processedTitles.add(article.title);
                }
              }
            }
          }
        } else {
          throw Exception('Failed to load page: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Error scraping news: $e');
      }
    }
    return allArticles.toList();
  }

  Future<List<ArticlesEntity>> scrapeLimitedNews(int maxArticles) async {
    Set<ArticlesEntity> allArticles = {};
    final Set<String> processedTitles = {};
    bool hasMoreContent = true;
    int fetchedArticles = 0;

    while (hasMoreContent && fetchedArticles < maxArticles) {
      try {
        var response = await http.get(IntoxiUtils.uri);

        if (response.statusCode == 200) {
          var document = parser.parse(response.body);
          var articles = document.querySelectorAll('article');

          if (articles.isEmpty) {
            hasMoreContent = false;
          } else {
            for (var articleElement in articles) {
              var article = _parseArticle(articleElement);

              if (article != null) {
                if (!processedTitles.contains(article.title)) {
                  allArticles.add(article);
                  processedTitles.add(article.title);
                  fetchedArticles++;
                  if (fetchedArticles >= maxArticles) {
                    break;
                  }
                }
              }
            }
          }
        } else {
          throw Exception('Failed to load page: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Error scraping news: $e');
      }
    }

    return allArticles.toList();
  }

  Future<ArticlesEntity> scrapeArticleDetails(
      String articleUrl, ArticlesEntity originalNewsEntity) async {
    try {
      var response = await http.get(Uri.parse(articleUrl));

      if (response.statusCode == 200) {
        var doc = parser.parse(response.body);

        final title = Scraper.docSelec(doc, 'h1.post-title.entry-title');
        final author = Scraper.docSelec(doc, '.post-byline .fn a');
        final date = Scraper.docSelecAttr(doc, 'time.published', 'datetime');
        final content = Scraper.docSelecAll(doc, '.entry p', '');
        var imageUrl = Scraper.docSelecAttr(doc, '.entry-inner img', 'src');

        Scraper.removeHtmlElementsList(content, [
          'twitter',
          '@',
          'Relacionado',
          'Staff',
          'Visual liberado junto do trailer'
        ]);

        return ArticlesEntity(
          title: title,
          author: author,
          date: date,
          content: content.join('\n'),
          imageUrl: imageUrl != 'NA' ? imageUrl : originalNewsEntity.imageUrl,
          resume: '',
          sourceUrl: originalNewsEntity.url,
          category: originalNewsEntity.category,
          url: originalNewsEntity.url,
          createdAt: originalNewsEntity.createdAt,
          updatedAt: DateTime.now(),
          site: SitesEnum.intoxi.name,
        );
      } else {
        throw Exception(
            'Failed to load article details: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error scraping article details: $e');
    }
  }

  ArticlesEntity? _parseArticle(Element articleElement) {
    var titleElement =
        articleElement.querySelector('h2.post-title.entry-title a');
    var imageUrlElement = articleElement.querySelector('.post-thumbnail img');
    var dateElement = articleElement.querySelector('time.published');
    var authorElement = articleElement.querySelector('.post-byline .fn a');
    var categoryElement = articleElement.querySelector('.post-category a');
    var contentElement = articleElement.querySelector('.entry p');

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
        resume: '',
        url: articleUrl,
        sourceUrl: '',
        site: SitesEnum.intoxi.name,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }
    return null;
  }
}
