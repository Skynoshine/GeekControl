import 'package:flutter/material.dart';
import 'package:geekcontrol/services/sites/wallpapers/webscraper/wallpaper.dart';

class WallpaperListScreen extends StatefulWidget {
  const WallpaperListScreen({super.key});

  @override
  State<WallpaperListScreen> createState() => _WallpaperListScreenState();
}

class _WallpaperListScreenState extends State<WallpaperListScreen> {
  List<String> _images = [];
  String _searchQuery = 'anime';

  @override
  void initState() {
    super.initState();
    _refreshContent();
  }

  Future<void> _refreshContent() async {
    final images = await WallpapersWebscrap().getWallpapers(_searchQuery);
    setState(() {
      _images = images;
    });
  }

  void _downloadImage(String imageUrl) async {
    await WallpapersWebscrap().downloadWallpaper(imageUrl);
  }

  void _showSearchPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String searchInput = '';
        return AlertDialog(
          title: const Text('Search Wallpapers'),
          content: TextField(
            onChanged: (value) {
              searchInput = value;
            },
            decoration:
                const InputDecoration(hintText: 'Pesquisar wallpaper...'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Pesquisar'),
              onPressed: () {
                setState(() {
                  _searchQuery = searchInput;
                });
                Navigator.of(context).pop();
                _refreshContent();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallpapers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchPopup,
          ),
        ],
      ),
      body: _images.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshContent,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.9,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ),
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Card(
                        shadowColor: Colors.black,
                        elevation: 6.0,
                        margin: const EdgeInsets.all(4.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.network(
                            _images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        right: 0.0,
                        child: IconButton(
                          icon: const Icon(Icons.download),
                          color: Colors.white,
                          onPressed: () => _downloadImage(_images[index]),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refreshContent,
        tooltip: 'Atualizar',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
