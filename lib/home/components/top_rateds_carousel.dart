import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/core/library/hitagi_cup/utils.dart';
import 'package:geekcontrol/home/components/carousel_skeletonizer.dart';
import 'package:geekcontrol/services/anilist/controller/anilist_controller.dart';
import 'package:geekcontrol/services/anilist/entities/rates_entity.dart';
import 'package:go_router/go_router.dart';

class TopRatedsCarousel extends StatelessWidget {
  const TopRatedsCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<MangasRates>>(
      future: AnilistController().getRates(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CarouselSkeletonizer();
        } else if (snapshot.hasError) {
          return Center(
              child: Text('Erro ao carregar dados ${snapshot.error}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HitagiText(
                      text: 'Favoritos da galera',
                      typography: HitagiTypography.button,
                    ),
                    IconButton(
                        onPressed: () => GoRouter.of(context).push('/'),
                        icon: const Icon(Icons.arrow_forward_rounded)),
                  ],
                ),
                const SizedBox(height: 4),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 250,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.2,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.4,
                  ),
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index, realIndex) {
                    MangasRates anime = snapshot.data![index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                anime.coverImage,
                                height: 200,
                                width: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      anime.meanScore.toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          width: 200,
                          child: Text(
                            Utils.maxCharacters(25, text: anime.title),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: anime.title.length > 8 ? 15 : 25,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
