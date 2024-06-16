import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:geekcontrol/services/sites/utils_scrap.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class WallpapersWebscrap {
  Future<List<String>> getWallpapers(String search) async {
    final doc = await Scraper()
        .document('https://www.uhdpaper.com/search?q=Anime&by-date=true');

    final img =
        Scraper.docSelecAllAttr(doc, '.post-outer-container img', 'src');
    final flare = await _wallpaperFlare(search);
    return [...flare, ...img];
  }

  Future<List<String>> _wallpaperFlare(String search) async {
    final doc = await Scraper().document(
        'https://www.wallpaperflare.com/search?wallpaper=$search&mobile=ok');

    final img = Scraper.docSelecAllAttr(doc, '.lazy', 'data-src');

    if (!img.contains('N/A')) {
      return img;
    }
    return img;
  }

  Future<void> downloadWallpaper(String uri) async {
    try {
      if (await Permission.storage.request().isGranted) {
        final url = Uri.parse(uri);
        final path = await _downloadPath();

        final file = File('$path/${url.pathSegments.last}');
        await file
            .writeAsBytes(await http.get(url).then((value) => value.bodyBytes));
        Logger().i('Wallpaper ${file.path} downloaded');
      } else {
        Logger().e('Storage permission denied');
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<String> _downloadPath() async {
    final directory = await getExternalStorageDirectory();
    final path = '${directory?.path}';

    final dir = Directory(path);
    await dir.create(recursive: true);

    return dir.path;
  }
}
