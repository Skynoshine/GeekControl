import 'package:flutter/material.dart';
import 'package:geekcontrol/articles/controller/articles_controller.dart';
import 'package:geekcontrol/articles/entities/noticie_entity.dart';
import 'package:geekcontrol/articles/pages/complete_article_page.dart';

class NoticiesPage extends StatefulWidget {
  const NoticiesPage({Key? key}) : super(key: key);

  @override
  State<NoticiesPage> createState() => _NoticiesPageState();
}

class _NoticiesPageState extends State<NoticiesPage> {
  final ArticlesController _ct = ArticlesController();
  late Future<List<ArticlesEntity>> _newsFuture;
  late int _newsCount;
  int _newsViewedCount = 0;

  @override
  void initState() {
    super.initState();
    _newsFuture = _ct.fetchNews();
    _newsCount = 0;
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
            _newsCount = newsList.length;

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
                        _newsViewedCount++;
                      });
                    });
                  },
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 1),
                      end: Offset.zero,
                    ).animate(animation),
                    child: Card(
                      elevation: 4,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
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
