import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:logger/logger.dart';

class VoceSabiaAnime {
  Future<List<ArticlesEntity>> fetchArticles() async {
    final List<ArticlesEntity> articlesList = [];
    const String uri = 'https://vocesabianime.com/';

    final doc = await Scraper().document(uri);
    final element = doc.querySelectorAll('.ultp-block-content-wrap.ultp-block-content-overlay');

    for (final e in element) {
      final title = Scraper.elementSelec(e, '.ultp-block-title a');
      final images =
          Scraper.elementSelecAttr(e, '.ultp-block-wrapper img', 'src');
      final date = Scraper.elementSelec(e,
          '.ultp-block-meta.ultp-block-meta-doubleslash.ultp-block-meta-noIcon span');
      final url = Scraper.elementSelecAttr(
          e,
          '.ultp-block-image.ultp-block-image-zoomIn.ultp-block-image-overlay.ultp-block-image-custom a',
          'href');

      final articles = ArticlesEntity(
        title: title,
        imageUrl: images,
        date: date,
        author: '',
        category: '',
        content: title,
        url: url,
        sourceUrl: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        resume: '',
        site: SitesEnum.voceSabiaAnime.key,
      );
      articlesList.add(articles);
      Logger().d(articles.title);
    }
    return articlesList;
  }
}
