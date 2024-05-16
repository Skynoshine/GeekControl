import '../../../../animes/articles/entities/articles_entity.dart';
import '../../../../animes/sites_enum.dart';
import '../../utils_scrap.dart';

class IntoxiArticles {
  Future<List<ArticlesEntity>> scrapeArticles(String uri) async {
    final List<ArticlesEntity> scrapeList = [];
    final doc = await Scraper().document(uri);
    final element = doc.querySelectorAll('article');

    for (final e in element) {
      final title = Scraper.elementSelec(e, '.post-title.entry-title a');
      final date = Scraper.elementSelecAttr(e, 'time.published', 'datetime');
      final author = Scraper.elementSelec(e, '.post-byline .fn a');
      final url =
          Scraper.elementSelecAttr(e, '.post-title.entry-title a', 'href');
      final category = Scraper.elementSelec(e, '.post-category a');
      final imageUrl =
          Scraper.elementSelecAttr(e, '.post-thumbnail img', 'src');
      final resume = Scraper.elementSelec(e, '.entry.excerpt.entry-summary');

      if (!scrapeList.any((article) => article.title == title)) {
        final articles = ArticlesEntity(
          title: title,
          imageUrl: imageUrl,
          date: date,
          author: author,
          category: category,
          content: '',
          url: url,
          sourceUrl: url,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          resume: resume,
          site: SitesEnum.intoxi.name,
        );
        scrapeList.add(articles);
      }
    }
    return scrapeList;
  }

  Future<ArticlesEntity> scrapeArticleDetails(
      String articleUrl, ArticlesEntity articles) async {
    final doc = await Scraper().document(articleUrl);

    final title = Scraper.docSelec(doc, 'h1.post-title.entry-title');
    final author = Scraper.docSelec(doc, '.post-byline .fn a');
    final date = Scraper.docSelecAttr(doc, 'time.published', 'datetime');
    final content = Scraper.docSelecAll(doc, '.entry p');
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
      imageUrl: imageUrl != 'NA' ? imageUrl : articles.imageUrl,
      resume: '',
      sourceUrl: articles.url,
      category: articles.category,
      url: articles.url,
      createdAt: articles.createdAt,
      updatedAt: DateTime.now(),
      site: SitesEnum.intoxi.name,
    );
  }
}
