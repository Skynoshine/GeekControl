import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class Scraper {
  Future<Document> document(String uri) async {
    try {
      final response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        return parser.parse(response.body);
      } else {
        throw Exception('Failed to load document');
      }
    } catch (e) {
      throw Exception('Error fetching document: $e');
    }
  }

  static String elementToString(List<String> elements) {
    return elements.join('\n');
  }

  static String elementSelec(Element element, String selector) {
    return element.querySelector(selector)?.text.trim() ?? 'NA';
  }

  static String elementSelecAttr(
      Element element, String selector, String attr) {
    return element.querySelector(selector)?.attributes[attr] ?? 'NA';
  }

  static String docSelec(Document doc, String query) {
    return doc.querySelector(query)?.text.trim() ?? 'NA';
  }

  static List<String> docSelecAll(Document doc, String query) {
    return doc.querySelectorAll(query).map((e) => e.text).toList();
  }

  static List<String> docSelecAllAttr(Document doc, String query, String attr) {
    return doc
        .querySelectorAll(query)
        .map((e) => e.attributes[attr] ?? 'NA')
        .toList();
  }

  static List<String> elementSelectAllAttr(
      Element element, String query, String attr) {
    return element
        .querySelectorAll(query)
        .map((e) => e.attributes[attr] ?? 'NA')
        .toList();
  }

  static List<String?> removeHtmlElementsList(
      List<String?> content, List<String> elements) {
    final updatedContent =
        content.where((c) => !elements.any((e) => c!.contains(e))).toList();
    content.clear();
    content.addAll(updatedContent);
    return content;
  }

  static String docSelecAttr(Document doc, String query, String attr) {
    return doc.querySelector(query)?.attributes[attr] ?? 'NA';
  }

  static List<String?> removeHtmlElements(
      List<String?> content, String element) {
    final updatedContent = content.where((c) => !c!.contains(element)).toList();
    content.clear();
    content.addAll(updatedContent);
    return content;
  }

  static List<String> extractImage(String query,
      Map<String, dynamic> tagToSelector, Document doc, String attr) {
    final images = docSelecAttr(doc, query, attr);
    final imagesElements = doc.querySelectorAll(query);
    final Set<String> uniqueImages = {};

    for (var selec in tagToSelector.values) {
      for (var element in imagesElements) {
        if (element.attributes[selec] != null) {
          uniqueImages.add(element.attributes[selec]!);
        }
      }
    }
    if (images != 'NA') {
      uniqueImages.add(images);
    }
    return uniqueImages.toList();
  }

  static List<String> extractImages(Document doc, String query,
      Map<String, String> tagToSelector, String attr) {
    final Set<String> uniqueImages = {};
    final imagesElements = doc.querySelectorAll(query);

    for (var selector in tagToSelector.values) {
      for (var element in imagesElements) {
        final attrValue = element.attributes[selector];
        if (attrValue != null) {
          uniqueImages.add(attrValue);
        }
      }
    }

    final images = docSelecAttr(doc, query, attr);
    if (images != 'NA') {
      uniqueImages.add(images);
    }

    return uniqueImages.toList();
  }

  static List<String> extractText(
      Document doc, String query, Map<String, String> tagToSelector) {
    final List<String> result = [];
    for (var selector in tagToSelector.values) {
      result.addAll(doc
          .querySelectorAll('$query $selector')
          .map((e) => e.text)
          .where((text) => text.isNotEmpty));
    }
    return result;
  }

  static String formatImage(String image) {
    return '${image.replaceAll("'", '').replaceAll('background-image: url(', '').replaceAll(');', '').split('.jpg')[0]}.jpg';
  }

  static List<String> formatImageList(List<String> images) {
    return images.map(formatImage).toList();
  }
}
