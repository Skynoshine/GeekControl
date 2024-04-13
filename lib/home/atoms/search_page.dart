import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/search/search_hitagi.dart';
import 'package:geekcontrol/repositories/anilist/anilist_repository.dart';

class SearchPage extends StatelessWidget {
  final AnilistRepository? repository;
  final String title = 'Overlord';
  const SearchPage({Key? key, this.repository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: HitagiSearch(
          repository: AnilistRepository(),
          textSearch: 'Pesquisar por um mangá',
          onSearch: (title) => repository!.searchManga(title: title),
        ),
      ),
    );
  }
}
