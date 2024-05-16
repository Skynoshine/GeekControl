import '../../../../animes/spoilers/entities/spoiler_entity.dart';
import '../../../../core/utils/api_utils.dart';
import '../../utils_scrap.dart';
import 'package:logger/logger.dart';

class SpoilersScrap {
  Future<List<SpoilersEntity>> getSpoilers() async {
    return await scrapeInitial();
  }

  Future<List<SpoilersEntity>> getDetails(
      {required SpoilersEntity entity}) async {
    return await scrapeDetails(entity);
  }
}

Future<List<SpoilersEntity>> scrapeDetails(SpoilersEntity entity) async {
  final doc = await Scraper().document(entity.url);

  final content = Scraper.docSelecAll(doc, '.entry-inner p');
  final images = Scraper.docSelecAllAttr(doc, '.entry-inner img', 'src');
  final video = Scraper.docSelecAttr(doc, '.entry-inner iframe', 'src');
  Logger().i(video);

  final List<SpoilersEntity> updatedSpoilers = content.map((content) {
    return SpoilersEntity(
      title: entity.title,
      imageUrl: entity.imageUrl,
      date: entity.date,
      resume: entity.resume,
      category: entity.category,
      content: content,
      url: entity.url,
      sourceUrl: entity.sourceUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      images: images,
    );
  }).toList();
  return updatedSpoilers;
}

Future<List<SpoilersEntity>> scrapeInitial() async {
  final List<SpoilersEntity> spoilersList = [];

  final doc = await Scraper().document(IntoxiUtils.spoilersStr);
  final elements = doc.querySelectorAll('.post-inner');

  for (final e in elements) {
    final title = Scraper.elementSelec(e, '.post-title.entry-title a');
    final published = Scraper.elementSelec(e, '.published.updated');
    final resume = Scraper.elementSelec(e, '.entry.excerpt.entry-summary p');
    final url =
        Scraper.elementSelecAttr(e, '.post-title.entry-title a', 'href');
    final category = Scraper.elementSelec(e, '.post-category');
    final image = Scraper.elementSelecAttr(e, '.post-thumbnail img', 'src');

    final spoiler = SpoilersEntity(
      title: title,
      imageUrl: image,
      date: published.toUpperCase(),
      resume: resume.trim(),
      category: category.toUpperCase(),
      content: '',
      url: url,
      sourceUrl: url,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      images: [],
    );
    spoilersList.add(spoiler);
  }
  return spoilersList;
}
