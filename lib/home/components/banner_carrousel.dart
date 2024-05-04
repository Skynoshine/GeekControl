import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geekcontrol/articles/controller/articles_controller.dart';
import 'package:geekcontrol/articles/entities/noticie_entity.dart';

class BannerCarousel extends StatelessWidget {
  final ArticlesController _articlesController = ArticlesController();

  BannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticlesEntity>>(
      future: _articlesController.getAllArticlesCache(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasData) {
          List<ArticlesEntity> articles = snapshot.data!;
          List<String> articleImageUrls =
              articles.map((article) => article.imageUrl!).toList();

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
            items: articles.asMap().entries.map((entry) {
              int index = entry.key;
              ArticlesEntity article = entry.value;
              String articleUrl = articleImageUrls[index];

              return Builder(
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(articleUrl),
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
                            article.title,
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
                  );
                },
              );
            }).toList(),
          );
        } else {
          return Center(
            child: Text(
                _articlesController.getArticlesCache(quantity: 5).toString()),
          );
        }
      },
    );
  }
}