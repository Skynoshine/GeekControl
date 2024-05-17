import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/components/fields_component.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/skeletonizer/articles_skeletonizer.dart';
import 'package:geekcontrol/services/anilist/controller/anilist_controller.dart';
import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';
import 'package:go_router/go_router.dart';

class ReleasesAnimesPage extends StatefulWidget {
  const ReleasesAnimesPage({super.key});

  @override
  State<ReleasesAnimesPage> createState() => _ReleasesAnimesPageState();
}

class _ReleasesAnimesPageState extends State<ReleasesAnimesPage> {
  final _ct = AnilistController();
  late Future<List<ReleasesAnilistEntity>> _future;
  final List<int> readers = [];

  @override
  void initState() {
    super.initState();
    _future = _ct.getReleasesAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).push('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Center(child: Text('Últimos lançamentos')),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HitagiSkeletonizer();
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ReleasesAnilistEntity releases = snapshot.data![index];
                return GestureDetector(
                  onTap: () => GoRouter.of(context).push('/details'),
                  child: Card(
                    margin: const EdgeInsets.all(8),
                    elevation: 4,
                    color: readers.contains(releases.id)
                        ? const Color.fromARGB(255, 169, 191, 209)
                        : Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: releases.bannerImage,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8),
                            ),
                            child: Image.network(
                              releases.bannerImage,
                              height: 130,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(6),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                releases.englishTitle,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            FieldsComponent(releases: releases),
                          ],
                        ),
                      ],
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
