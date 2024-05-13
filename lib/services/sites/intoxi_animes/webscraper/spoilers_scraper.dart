import 'package:geekcontrol/animes/spoilers/entities/spoiler_entity.dart';
import 'package:geekcontrol/core/utils/api_utils.dart';
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:logger/logger.dart';

class SpoilersScrap {
  Future<List<SpoilersEntity>> getSpoilers() async {
    final response = await http.get(IntoxiUtils.spoilers);

    if (response.statusCode == 200) {
      final document = parser.parse(response.body);
      final elements = document.querySelectorAll('.post-inner');
      return scrapeInitial(elements);
    }
    return [];
  }

  Future<List<SpoilersEntity>> getDetails(SpoilersEntity entity) async {
    return await scrapeDetails(entity);
  }
}

Future<List<SpoilersEntity>> scrapeDetails(SpoilersEntity entity) async {
  try {
    final http.Response response = await http.get(Uri.parse(entity.url));
    if (response.statusCode == 200) {
      final Document document = parser.parse(response.body);
      final elements = document.querySelectorAll('.entry-inner p');

      final List<String> contents =
          elements.map((element) => element.text).toList();

      final imagesElement = document.querySelectorAll('.entry-inner img');

      final List<String?> images =
          imagesElement.map((element) => element.attributes['src']).toList();

      final List<SpoilersEntity> updatedSpoilers = contents.map((content) {
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
  } catch (e) {
    Logger().e('Error scraping details: $e');
  }
  return [];
}

Future<List<SpoilersEntity>> scrapeInitial(List<Element> elements) async {
  final List<SpoilersEntity> spoilersList = [];

  for (final element in elements) {
    final String title =
        element.querySelector('.post-title.entry-title a')?.text ?? '';
    final String? published = element.querySelector('.published.updated')?.text;
    final String resume =
        element.querySelector('.entry.excerpt.entry-summary p')?.text ?? '';
    final String url = element
            .querySelector('.post-title.entry-title a')
            ?.attributes['href'] ??
        '';
    final String category =
        element.querySelector('.post-category')?.text ?? 'N/A';
    final String image =
        element.querySelector('.post-thumbnail img')?.attributes['src'] ??
            'N/A';

    final spoiler = SpoilersEntity(
      title: title,
      imageUrl: image,
      date: published!.toUpperCase(),
      resume: resume,
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
