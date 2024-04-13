import 'package:flutter/material.dart';
import 'package:geekcontrol/repositories/anilist/anilist_repository.dart';
import 'package:geekcontrol/repositories/anilist/entities/manga_anilist_entity.dart';
import 'package:geekcontrol/repositories/anilist/entities/reviews_entity.dart';
import 'package:geekcontrol/reviews/pages/reviews_page.dart';

class HitagiSearchWidget extends StatefulWidget {
  final AnilistRepository searchController;

  const HitagiSearchWidget({Key? key, required this.searchController})
      : super(key: key);

  @override
  State<HitagiSearchWidget> createState() => _HitagiSearchWidgetState();
}

class _HitagiSearchWidgetState extends State<HitagiSearchWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 350,
            child: TextField(
              strutStyle: const StrutStyle(height: 1.0, leading: 1),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8.0),
                hintText: 'Pesquisar por um mangá',
                hintStyle: TextStyle(
                  color: Color.fromARGB(65, 0, 0, 0),
                ),
                filled: true,
                fillColor: Color.fromARGB(31, 130, 130, 130),
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              controller: _controller,
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<AnilistEntity>(
              future:
                  widget.searchController.searchManga(title: _controller.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text('Erro ao buscar mangá'),
                  );
                } else if (snapshot.hasData && snapshot.data != null) {
                  List<AnilistEntity> mangas = [snapshot.data!];
                  return ListView.builder(
                    itemCount: mangas.length,
                    itemBuilder: (context, index) {
                      AnilistEntity manga = mangas[index];
                      return ListTile(
                        title: Text(
                          manga.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: NetworkImage(manga.media.coverImage),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewsPage(
                                reviews: const <MangaReviewEntity>[],
                                mangasAnilist: [manga],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('Nenhum mangá encontrado'),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
