import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';


class OtakuPT {
  Future<List<ArticlesEntity>> fetchArticles() async {
    const String uri = 'https://www.otakupt.com/category/anime';

    final doc = await Scraper().document(uri);

    final List<ArticlesEntity> articlesList = [];
    final element = doc.querySelectorAll(
        '.tdb_module_loop.td_module_wrap.td-animation-stack.td-cpt-post');

    for (final e in element) {
      final title = Scraper.elementSelec(e, '.entry-title.td-module-title a');
      final imageElement =
          Scraper.elementSelecAttr(e, '.entry-thumb.td-thumb-css', 'style');
      final image = Scraper.formatImage(imageElement);
      final author = Scraper.elementSelec(e, '.td-post-author-name a');
      final date = Scraper.elementSelec(e, '.td-post-date');
      final url =
          Scraper.elementSelecAttr(e, '.entry-title.td-module-title a', 'href');

      final articles = ArticlesEntity(
        title: title,
        imageUrl: image,
        date: date,
        author: author,
        category: '',
        content: '',
        url: url,
        sourceUrl: url,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: '',
        site: SitesEnum.otakuPt.name,
      );
      articlesList.add(articles);
    }
    final manga = await _mangasArticles();
    return [...articlesList, ...manga];
  }

  Future<List<ArticlesEntity>> searchArticles(String article) async {
    final List<ArticlesEntity> articlesList = [];
    final doc =
        await Scraper().document('https://www.otakupt.com/?s=$article');

    final elements = doc.querySelectorAll(
        '.tdb_module_loop.td_module_wrap.td-animation-stack.td-cpt-post');

    for (final e in elements) {
      final title = Scraper.elementSelec(e, '.entry-title.td-module-title a');
      final url =
          Scraper.elementSelecAttr(e, '.entry-title.td-module-title a', 'href');
      final author = Scraper.elementSelec(e, '.td-post-author-name a');
      final date = Scraper.elementSelec(e, '.td-post-date');
      final imageElement =
          Scraper.elementSelecAttr(e, '.entry-thumb.td-thumb-css', 'style');
      final image = Scraper.formatImage(imageElement);

      final articles = ArticlesEntity(
        title: title,
        imageUrl: image,
        date: date,
        author: author,
        category: '',
        content: '',
        url: url,
        sourceUrl: url,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: '',
        site: SitesEnum.otakuPt.name,
      );
      articlesList.add(articles);
    }
    return articlesList;
  }

  Future<ArticlesEntity> getArticleDetailsScrape(
      String url, ArticlesEntity entity) async {
    final doc = await Scraper().document(url);

    final List<String?> contentElements = Scraper.extractText(
      doc,
      '.tdb-block-inner.td-fix-index',
      {
        'p': 'p',
      },
    );

    var content = contentElements
        .where((element) => element != null && element.trim().isNotEmpty)
        .join('\n');

    Scraper.removeHtmlElementsList(contentElements,
        ['<span style', 'Δdocument', 'Tags', 'Diário Otaku', 'IberAnime']);

    content = contentElements.join('\n');

    return ArticlesEntity(
      title: entity.title,
      imageUrl: entity.imageUrl,
      date: entity.date,
      author: entity.author,
      category: entity.category,
      content: content,
      url: url,
      resume: '',
      sourceUrl: entity.sourceUrl ?? url,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now(),
      imagesPage: null,
      site: SitesEnum.animesNew.name,
    );
  }

  Future<List<ArticlesEntity>> _mangasArticles() async {
    const String uri = 'https://www.otakupt.com/category/manga/';
    final doc = await Scraper().document(uri);

    final List<ArticlesEntity> articlesList = [];
    final element = doc.querySelectorAll(
        '.tdb_module_loop.td_module_wrap.td-animation-stack.td-cpt-post');

    for (final e in element) {
      final title = Scraper.elementSelec(e, '.entry-title.td-module-title a');
      final imageElement =
          Scraper.elementSelecAttr(e, '.entry-thumb.td-thumb-css', 'style');
      final image = Scraper.formatImage(imageElement);
      final author = Scraper.elementSelec(e, '.td-post-author-name a');
      final date = Scraper.elementSelec(e, '.td-post-date');
      final url =
          Scraper.elementSelecAttr(e, '.entry-title.td-module-title a', 'href');

      final articles = ArticlesEntity(
        title: title,
        imageUrl: image,
        date: date,
        author: author,
        category: '',
        content: '',
        url: url,
        sourceUrl: url,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: '',
        site: SitesEnum.otakuPt.name,
      );
      articlesList.add(articles);
    }
    return articlesList;
  }
}
