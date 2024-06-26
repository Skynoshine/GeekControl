import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as parser;
import 'package:http/http.dart' as http;

class MangaNews {
  Future<List<ArticlesEntity>> scrapeArticles() async {
    final List<ArticlesEntity> scrapeList = [];

    final Document doc = await Scraper().document(AnimesNewUtils.uriStr);
    final articleElements = doc.querySelectorAll('.list-holder');

    for (final element in articleElements) {
      if (!element.classes.contains('sidebar-wrap')) {
        final title = Scraper.elementSelec(element, '.entry-title a');
        final description = Scraper.elementSelec(element, '.entry-summary');
        final image =
            Scraper.elementSelecAttr(element, '.block-inner img', 'src');
        final author = Scraper.elementSelec(element, '.meta-el.meta-author a');
        final date = Scraper.elementSelec(element, '.meta-el.meta-date');
        final sourceUrl =
            Scraper.elementSelecAttr(element, '.entry-title a', 'href');

        if (title.isNotEmpty &&
            description.isNotEmpty &&
            image.isNotEmpty &&
            author.isNotEmpty &&
            date.isNotEmpty) {
          if (!scrapeList.any((article) => article.title == title)) {
            final article = ArticlesEntity(
              title: title,
              imageUrl: image,
              date: date,
              author: author,
              resume: description,
              category: '',
              content: '',
              url: sourceUrl,
              sourceUrl: sourceUrl,
              site: SitesEnum.animesNew.name,
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            );
            scrapeList.add(article);
          }
        }
      }
    }
    return scrapeList;
  }

  Future<ArticlesEntity> scrapeArticleDetails(
      String url, ArticlesEntity entity) async {
    final Document doc = await Scraper().document(url);

    final images = Scraper.extractImages(
        doc, '.s-ct img', {'data': 'data-lazy-src'}, 'src');

    final List<String?> content = Scraper.extractText(
      doc,
      '.s-ct',
      {
        'p': 'p',
        'em': 'em',
        'h1': 'h1',
        'li': 'li',
      },
    );

    Scraper.removeHtmlElementsList(content, ['<img', '<iframe']);

    return ArticlesEntity(
      title: entity.title,
      imageUrl: entity.imageUrl,
      date: entity.date,
      author: entity.author,
      category: entity.category,
      content: content.join('\n'),
      url: url,
      resume: '',
      sourceUrl: entity.sourceUrl ?? url,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now(),
      imagesPage: images,
      site: SitesEnum.animesNew.name,
    );
  }

  Future<List<ArticlesEntity>> searchArticle(String article) async {
    const String path = '.p-wrap.p-grid.p-grid-1';

    final Document doc =
        await Scraper().document('https://animenew.com.br/?s=$article');
    final articleElements = Scraper.docSelecAll(doc, '$path h3');
    final images = Scraper.docSelecAllAttr(doc, '$path img', 'src');
    final description = Scraper.docSelecAll(doc, '$path p');
    final date = Scraper.docSelecAll(doc, '$path .meta-el.meta-date');
    final author = Scraper.docSelecAll(doc, '$path .meta-el.meta-author a');
    final titles = Scraper.docSelecAll(doc, '$path h3 a');
    final urls = Scraper.docSelecAllAttr(doc, '$path h3 a', 'href');

    List<ArticlesEntity> articlesList = [];
    for (int i = 0; i < articleElements.length; i++) {
      ArticlesEntity article = ArticlesEntity(
        title: titles[i],
        imageUrl: images[i],
        date: date[i],
        author: author[i],
        category: '',
        content: '',
        url: urls[i],
        sourceUrl: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: description[i],
        site: SitesEnum.animesNew.name,
      );
      articlesList.add(article);
    }
    return articlesList;
  }

  Future<List<ArticlesEntity>> scrapeLimitedNewsList(int articleCount) async {
    final List<ArticlesEntity> scrapeList = [];
    final baseUrl = AnimesNewUtils.uri.toString();

    int fetchedArticles = 0;
    int page = 1;

    while (fetchedArticles < articleCount) {
      final url = page == 1 ? baseUrl : '$baseUrl/page/$page/';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final doc = parser.parse(response.body);
        final articleElements = doc.querySelectorAll('.p-wrap');

        for (final element in articleElements) {
          if (!element.classes.contains('sidebar-wrap')) {
            final title = Scraper.docSelec(doc, 'entry-title a');
            final description = Scraper.docSelec(doc, '.entry-summary');
            final img = Scraper.docSelecAttr(doc, '.feat-holder img', 'src');
            final author = Scraper.docSelec(doc, '.meta-el.meta-author a');
            final date = Scraper.docSelec(doc, '.meta-el.meta-date');
            final src = Scraper.docSelecAttr(doc, '.entry-title a', 'href');

            if (title.isNotEmpty &&
                description.isNotEmpty &&
                img.isNotEmpty &&
                author.isNotEmpty &&
                date.isNotEmpty) {
              if (!scrapeList.any((article) => article.title == title)) {
                final article = ArticlesEntity(
                  title: title,
                  imageUrl: img,
                  date: date,
                  author: author,
                  resume: description,
                  category: '',
                  content: '',
                  url: src,
                  sourceUrl: src,
                  site: SitesEnum.animesNew.name,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                scrapeList.add(article);
                fetchedArticles++;
                if (fetchedArticles >= articleCount) {
                  break;
                }
              }
            }
          }
        }
        page++;
      } else {
        throw Exception('Failed to load articles from page $page');
      }
    }
    return scrapeList;
  }
}
