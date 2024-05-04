import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/core/library/hitagi_cup/utils.dart';
import 'package:geekcontrol/home/components/cover_responsive.dart';
import 'package:geekcontrol/services/repositories/anilist/anilist_repository.dart';
import 'package:geekcontrol/services/repositories/anilist/entities/manga_anilist_entity.dart';
import 'package:geekcontrol/services/repositories/anilist/entities/releases_anilist_entity.dart';
import 'package:geekcontrol/services/repositories/anilist/utils/convert_state.dart';

class AnimesCarouselWidget extends StatelessWidget {
  const AnimesCarouselWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: AnilistRepository().fetchAllData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final releases = snapshot.data![0] as ReleasesAnilistEntity;
          final anilist = snapshot.data![1] as AnilistEntity;

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
                    height: MediaQuery.of(context).size.height * 0.2 + 35,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.5,
                  top: 60,
                  left: 60 / 30,
                  right: 60 / 30,
                  child: Row(
                    children: [
                      SizedBox(
                        height: CoverResponsive.calcResponsiveHeigth(context),
                        width: CoverResponsive.calcResponsiveWidth(context),
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
                      const SizedBox(width: 12.0),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HitagiText(
                            text: releases.englishTitle,
                            typography: HitagiTypography.giga,
                          ),
                          HitagiText(
                            text:
                                '${anilist.review.first.averageScore}% Gostaram',
                            icon: Icons.star,
                            typography: HitagiTypography.title,
                            iconColor: const Color.fromARGB(255, 223, 201, 4),
                          ),
                          HitagiText(
                            text: ConvertState.toPortuguese(
                                anilist.review.first.status),
                            typography: HitagiTypography.title,
                            icon: Icons.remove_red_eye_sharp,
                          ),
                          HitagiText(
                            text:
                                '${anilist.genres.first} ⚬ ${anilist.genres[1]}',
                            size: 16,
                            icon: Icons.book,
                            isBold: true,
                          ),
                          HitagiText(
                            text: Utils.timeFromMSeconds(releases.seasonYear),
                            size: 16,
                            icon: Icons.book,
                            isBold: true,
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
}
