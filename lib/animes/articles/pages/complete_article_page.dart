import 'package:flutter/material.dart';
import '../controller/articles_controller.dart';
import '../entities/articles_entity.dart';
import 'components/carousel_articles.dart';
import '../../../core/utils/loader_indicator.dart';
import 'package:logger/logger.dart';

class CompleteArticlePage extends StatelessWidget {
  final ArticlesEntity news;
  final String current;
  final ArticlesController _articlesController = ArticlesController();

  CompleteArticlePage({super.key, required this.news, required this.current});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Notícia'),
      ),
      body: FutureBuilder<ArticlesEntity>(
        future: _articlesController.fetchArticleDetails(
          news.sourceUrl!.isEmpty ? news.url : news.sourceUrl!,
          news,
          news.site,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loader.pacman(),
            );
          } else if (snapshot.hasError) {
            Logger().e(snapshot.error);
            return Center(
              child: Text('Erro: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            ArticlesEntity article = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  article.imagesPage != null
                      ? CarouselArticles(
                          images: article.imagesPage!, title: article.title)
                      : CarouselArticles(
                          images: [article.imageUrl!], title: article.title),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Por ${article.author} | ${article.date}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          article.content,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('Nenhum dado disponível.'),
            );
          }
        },
      ),
    );
  }
}
