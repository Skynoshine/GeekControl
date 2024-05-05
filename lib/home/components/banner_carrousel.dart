import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geekcontrol/articles/controller/articles_controller.dart';
import 'package:geekcontrol/articles/entities/articles_entity.dart';
import 'package:geekcontrol/articles/pages/complete_article_page.dart';
import 'package:geekcontrol/core/utils/loader_indicator.dart';

class BannerCarousel extends StatelessWidget {
  final ArticlesController _articlesController = ArticlesController();
  BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticlesEntity>>(
      future: _articlesController.getAllArticlesCache(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Loader.pacman());
        } else if (snapshot.hasData) {
          List<ArticlesEntity> articles = snapshot.data!;
          return CarouselSlider(
            options: CarouselOptions(
              height: 200,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(seconds: 1),
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
            items: articles.map((entry) {
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return FadeTransition(
                        opacity: animation,
                        child: CompleteArticlePage(news: entry),
                      );
                    },
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(entry.imageUrl!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 7,
                      left: 2,
                      right: 2,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 20,
                        padding: const EdgeInsets.all(4.0),
                        color: Colors.black.withOpacity(0.7),
                        child: Text(
                          entry.title,
                          maxLines: 3,
                          overflow: TextOverflow.fade,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        } else {
          return const Center(
            child: Text(
              'Nenhum dado disponível',
              style: TextStyle(color: Colors.red),
            ),
          );
        }
      },
    );
  }
}
