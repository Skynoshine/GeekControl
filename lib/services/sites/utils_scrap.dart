import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:logger/logger.dart';

class Scraper {
  Future<Document> document(String uri) async {
    final response = await http.get(Uri.parse(uri));
    final document = parser.parse(response.body);
    return document;
  }

  static String elementSelec(Element element, String selector) {
    final result = element.querySelector(selector)?.text.trim() ?? 'NA';
    return result;
  }

  static String elementSelecAttr(
      Element element, String selector, String attr) {
    return element.querySelector(selector)?.attributes[attr] ?? 'NA';
  }

  static String docSelec(Document doc, String query) {
    return doc.querySelector(query)?.text.trim() ?? 'NA';
  }

  static List<String?> docSelecAll(Document doc, String query, String attr) {
    final r = doc.querySelectorAll(query);
    Logger().i(r.first);
    final List<String?> result = r.map((e) => e.text).toList();
    return result;
  }

  static List<String?> elementSelecAll(
      Element element, String query, String attr) {
    final r = element.querySelectorAll(query);
    final List<String?> result = r.map((e) => e.attributes[attr]).toList();
    return result;
  }

  static String docSelecAttr(Document doc, String query, String attr) {
    return doc.querySelector(query)?.attributes[attr] ?? 'NA';
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

  static List<String?> removeHtmlElements(
      List<String?> content, String element) {
    final updatedContent = content.where((c) => !c!.contains(element)).toList();
    content.clear();
    content.addAll(updatedContent);
    return content;
  }

  static List<String?> removeHtmlElementsList(
      List<String?> content, List<String> elements) {
    final updatedContent =
        content.where((c) => !elements.any((e) => c!.contains(e))).toList();
    content.clear();
    content.addAll(updatedContent);
    return content;
  }

  static List<String?> extractText(
      String query, Map<String, dynamic> tagToSelector, Document doc) {
    final List<String?> result = [];

    for (var selec in tagToSelector.values) {
      final elements = doc.querySelectorAll('$query $selec');
      for (var element in elements) {
        if (element.text.isNotEmpty) {
          result.add(element.text);
        }
      }
    }

    return result;
  }
}
