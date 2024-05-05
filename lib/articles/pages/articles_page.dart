import 'package:flutter/material.dart';
import 'package:geekcontrol/articles/controller/articles_controller.dart';
import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/articles/pages/complete_article_page.dart';
import 'package:geekcontrol/core/utils/loader_indicator.dart';
import 'package:geekcontrol/services/cache/controller/local_cache_controller.dart';

class NoticiesPage extends StatefulWidget {
  const NoticiesPage({super.key});

  @override
  State<NoticiesPage> createState() => _NoticiesPageState();
}

class _NoticiesPageState extends State<NoticiesPage> {
  final ArticlesController _articlesController = ArticlesController();
  final LocalCacheController _cacheController = LocalCacheController();
  late Future<List<ArticlesEntity>> _newsFuture;
  final List<String> _readTitles = [];
  final int _newsCount = 0;
  int _newsViewedCount = 0;

  @override
  void initState() {
    super.initState();
    _newsFuture = _articlesController.getAllArticlesCache();

    setState(() {
      _articlesController.loadCacheReads(
          _newsCount, _newsViewedCount, _readTitles);
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
            return Center(
              child: Loader.pacman(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar notícias: ${snapshot.error}'),
            );
          } else {
            final newsList = snapshot.data!;
            return AnimatedList(
              initialItemCount: newsList.length,
              itemBuilder: (context, index, animation) {
                final news = newsList[index];
                final isRead = _isRead(news.title);

                return GestureDetector(
                  onTap: () {
                    if (!isRead) {
                      _cacheController.insert(news.title, true, 1);
                      setState(() {
                        _readTitles.add(news.title);
                        _newsViewedCount++;
                      });
                    }
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
                    );
                  },
                  onLongPress: () async {
                    if (isRead) {
                      await _cacheController.remove(news.title);
                      setState(() {
                        _readTitles.remove(news.title);
                        _newsViewedCount--;
                      });
                    }
                  },
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Card(
                      elevation: 4,
                      color: isRead
                          ? const Color.fromARGB(255, 240, 206, 206)
                          : null,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          if (isRead)
                            const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.menu_book,
                                ),
                              ),
                            ),
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
