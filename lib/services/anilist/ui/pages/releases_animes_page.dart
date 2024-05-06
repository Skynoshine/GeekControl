import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/core/utils/convert_state.dart';
import 'package:geekcontrol/core/utils/loader_indicator.dart';
import 'package:geekcontrol/services/anilist/controller/anilist_controller.dart';
import 'package:geekcontrol/services/anilist/entities/releases_anilist_entity.dart';

class ReleasesAnimesPage extends StatefulWidget {
  const ReleasesAnimesPage({super.key});

  @override
  State<ReleasesAnimesPage> createState() => _ReleasesAnimesPageState();
}

class _ReleasesAnimesPageState extends State<ReleasesAnimesPage> {
  final _ct = AnilistController();
  late Future<List<ReleasesAnilistEntity>> _future;

  @override
  void initState() {
    super.initState();
    _future = _ct.getReleasesAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimos lançamentos'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Loader.pacman(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                ReleasesAnilistEntity releases = snapshot.data![index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  elevation: 4,
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
                          Text(
                            releases.englishTitle,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            ConvertState.toPortuguese(releases.status),
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          HitagiText.icon(
                            'Autor - ${releases.author}',
                            Icons.person,
                          ),
                        ],
                      ),
                    ],
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
