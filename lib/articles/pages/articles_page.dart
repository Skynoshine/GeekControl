import 'package:flutter/material.dart';
import 'package:geekcontrol/articles/controller/articles_controller.dart';
import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/articles/pages/complete_article_page.dart';
import 'package:geekcontrol/services/cache/controller/local_cache_controller.dart';

class NoticiesPage extends StatefulWidget {
  const NoticiesPage({Key? key}) : super(key: key);

  @override
  State<NoticiesPage> createState() => _NoticiesPageState();
}

class _NoticiesPageState extends State<NoticiesPage> {
  final ArticlesController _ct = ArticlesController();
  late Future<List<ArticlesEntity>> _newsFuture;
  int _newsCount = 0;
  int _newsViewedCount = 0;
  final LocalCacheController _cacheController = LocalCacheController();
  late List<String> _readTitles;

  @override
  void initState() {
    super.initState();
    _newsFuture = _ct.getAllArticlesCache();
    _loadCachedReads();
  }

  Future<void> _loadCachedReads() async {
    final cachedItems = await _cacheController.get();
    setState(() {
      for (var item in cachedItems) {
        int quantity = item['quantity'];
        _newsCount = quantity;
      }
      _readTitles = cachedItems.map<String>((item) => item['value']).toList();
      _newsViewedCount = _readTitles.length;
    });

  }

  bool _isRead(String title) {
    return _readTitles.contains(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notícias'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.article_outlined),
                const SizedBox(width: 4),
                Text('$_newsViewedCount/$_newsCount'),
              ],
            ),
          ),
        ],
      ),
      body: FutureBuilder<List<ArticlesEntity>>(
        future: _newsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar notícias: ${snapshot.error}'),
            );
          } else {
            final newsList = snapshot.data!;
            if (_newsCount == 0) {
              _newsCount = newsList.length;
            }
            return AnimatedList(
              initialItemCount: newsList.length,
              itemBuilder: (context, index, animation) {
                final news = newsList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: CompleteArticlePage(news: news),
                          );
                        },
                      ),
                    ).then((_) {
                      setState(() {
                        if (!_isRead(news.title)) {
                          _cacheController.insert(
                              news.title, true, newsList.length);

                          _readTitles.add(news.title);
                          _newsViewedCount++;
                        }
                      });
                    });
                  },
                  onLongPress: () {
                    setState(() {
                      if (_isRead(news.title)) {
                        _cacheController.remove(news.title);
                        _readTitles.remove(news.title);
                        _newsViewedCount--;
                      }
                    });
                  },
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Card(
                      elevation: 4,
                      color: _isRead(news.title)
                          ? const Color.fromARGB(255, 240, 206, 206)
                          : null,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _isRead(news.title)
                              ? const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Icon(
                                      Icons.menu_book,
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          Hero(
                            tag: news.imageUrl!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                news.imageUrl!,
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Por ${news.author} | ${news.date}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
