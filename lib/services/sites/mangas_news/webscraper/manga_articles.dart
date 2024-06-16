import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:html/dom.dart';

class AnimesnewMangasArticles {
  Future<List<ArticlesEntity>> getMangasScrap() async {
    final List<ArticlesEntity> scrapeList = [];

    final url = AnimesNewUtils.uriStr;
    final Document doc = await Scraper().document(url);
    final element = doc.querySelectorAll('.p-wrap.p-grid.p-grid-2');

    for (final elements in element) {
      final title = Scraper.elementSelec(elements, '.entry-title a');
      final resume = Scraper.elementSelec(elements, '.entry-summary');
      final img = Scraper.elementSelecAttr(elements, '.feat-holder img', 'src');
      final author = Scraper.elementSelec(elements, '.meta-inner.is-meta a');
      final date = Scraper.elementSelec(elements, '.meta-inner.is-meta time');

      if (title.isNotEmpty &&
          resume.isNotEmpty &&
          img.isNotEmpty &&
          author.isNotEmpty &&
          date.isNotEmpty) {
        if (!scrapeList.any((article) => article.title == title)) {
          final article = ArticlesEntity(
            title: title,
            imageUrl: img,
            date: date,
            author: author,
            resume: resume,
            site: SitesEnum.animesNew.name,
            category: '',
            content: '',
            url: '',
            sourceUrl: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );

          scrapeList.add(article);
        }
      }
    }
    return scrapeList;
  }

  Future getMangasDetails(ArticlesEntity entity, String url) async {
    final doc = await Scraper().document(url);
    final images = Scraper.docSelecAttr(doc, '.s-ct img', 'src');
    final imagesElements = doc.querySelectorAll('.s-ct img');
    final List<String> listImages = [];

    for (var element in imagesElements) {
      if (element.attributes['data-lazy-src'] != null) {
        listImages.add(element.attributes['data-lazy-src']!);
      }
      if (images != 'NA') {
        listImages.add(images);
      }
    }

    final contentList = Scraper.extractText(
      doc,
      '.s-ct',
      {
        'p': 'p',
        'li': 'li',
      },
    );

    return ArticlesEntity(
      title: entity.title,
      imageUrl: entity.imageUrl,
      date: entity.date,
      site: SitesEnum.animesNew.name,
      author: entity.author,
      category: entity.category,
      content: contentList.toString(),
      url: url,
      sourceUrl: entity.sourceUrl,
      createdAt: entity.createdAt,
      updatedAt: DateTime.now(),
      resume: entity.resume,
      imagesPage: listImages,
    );
  }
}
