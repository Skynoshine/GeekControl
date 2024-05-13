import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/controller/articles_controller.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';
import 'package:geekcontrol/animes/articles/pages/complete_article_page.dart';
import 'package:geekcontrol/animes/components/floating_button.dart';
import 'package:geekcontrol/animes/sites_enum.dart';
import 'package:geekcontrol/core/utils/loader_indicator.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  final List<String> _readTitles = [];
  ArticlesController ct = ArticlesController();

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => ct.changedSite(SitesEnum.intoxi));
    ct.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  bool _isRead(String title) {
    return _readTitles.contains(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => GoRouter.of(context).go('/'),
            icon: const Icon(Icons.arrow_back)),
        title: const Center(child: Text('Últimas Notícias')),
      ),
      floatingActionButton: FloattingButton(ct: ct),
      body: FutureBuilder<List<ArticlesEntity>>(
        future: ct.articles,
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
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.extentAfter == 0) {
                  Logger().d('Carregando mais notícias...');
                }
                return false;
              },
              child: AnimatedList(
                initialItemCount: newsList.length,
                itemBuilder: (context, index, animation) {
                  final news = newsList[index];
                  final isRead = _isRead(news.title);
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return FadeTransition(
                            opacity: animation,
                            child: CompleteArticlePage(news: news, current: news.site),
                          );
                        },
                      ),
                    ),
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
                              tag: news.title,
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
              ),
            );
          }
        },
      ),
    );
  }
}
