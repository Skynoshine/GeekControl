import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/repositories/anilist/anilist_repository.dart';
import 'package:geekcontrol/repositories/anilist/entities/releases_anilist_entity.dart';

class AnimesCarouselWidget extends StatelessWidget {
  const AnimesCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ReleasesAnilistEntity>(
      future: _fetchReleases(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final releases = snapshot.data!;
          return Scaffold(
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Image.network(
                    releases.bannerImage,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2 + 40,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.5,
                  top: MediaQuery.of(context).size.height * 0.1,
                  left: MediaQuery.of(context).size.height * 0.1 - 55,
                  child: Row(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width / 2.3,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              releases.coverImage,
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.high,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HitagiText(
                            text: releases.englishTitle,
                            typography: HitagiTypography.giga,
                          ),
                          const HitagiText(
                            text: 'Notas - 7/10',
                            typography: HitagiTypography.title,
                            icon: Icons.star,
                            iconColor: Color.fromARGB(255, 223, 201, 4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<ReleasesAnilistEntity> _fetchReleases() async {
    return AnilistRepository().getReleasesAnimes();
  }
}
