import 'package:flutter/material.dart';
import 'package:geekcontrol/core/library/hitagi_cup/features/text/hitagi_text.dart';
import 'package:geekcontrol/services/repositories/anilist/anilist_repository.dart';

class SearchPage extends StatelessWidget {
  final AnilistRepository? repository;
  final String title = 'Overlord';
  const SearchPage({super.key, this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesquisar"),
      ),
      body: const Center(
        child: HitagiText(
          text: 'indisponível',
        ),
      ),
    );
  }
}
