import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:logger/logger.dart';

class AnimeUnited {
  Future<List<ArticlesEntity>> fetchArticles() async {
    final List<ArticlesEntity> articlesList = [];
    const String uri = 'https://www.animeunited.com.br/';

    final doc = await Scraper().document(uri);
    final element = doc.querySelectorAll('.col-12.col-4-tablet.post-column');

    for (var e in element) {
      final title = Scraper.elementSelec(e, '.entry-content p');
      final images = Scraper.elementSelecAttr(
          e, '.col-12.col-4-tablet.post-column img', 'data-lazy-src');
      final href = Scraper.elementSelecAttr(
          e, '.col-12.col-4-tablet.post-column a', 'href');
      final date = Scraper.elementSelec(e, '.entry-date.published.updated');

      final articles = ArticlesEntity(
        title: title,
        imageUrl: images,
        date: date,
        author: 'N/A',
        category: '',
        content: '',
        url: href,
        sourceUrl: href,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: '',
        site: SitesEnum.animeUnited.key,
      );
      articlesList.add(articles);
      Logger().i(articles.url);
    }
    return articlesList;
  }

  Future<ArticlesEntity> scrapeArticleDetails(
      String articleUrl, ArticlesEntity articles) async {
    final doc = await Scraper().document(articleUrl);
    final content = Scraper.docSelecAll(doc, '.container-full p');

    Logger().i(content);
    return ArticlesEntity(
      title: articles.title,
      author: articles.author,
      date: articles.date,
      content: content.join('\n'),
      imageUrl: articles.imageUrl,
      resume: '',
      sourceUrl: articles.url,
      category: articles.category,
      url: articles.url,
      createdAt: articles.createdAt,
      updatedAt: DateTime.now(),
      site: SitesEnum.animeUnited.name,
    );
  }
}
