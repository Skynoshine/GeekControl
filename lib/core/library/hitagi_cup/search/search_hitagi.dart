import 'package:flutter/material.dart';
import 'package:geekcontrol/repositories/anilist/anilist_repository.dart';
import 'package:geekcontrol/repositories/anilist/entities/manga_anilist_entity.dart';

class HitagiSearch extends StatefulWidget {
  final AnilistRepository repository;
  final String textSearch;
  final Future<AnilistEntity> Function(String) onSearch;

  const HitagiSearch(
      {Key? key,
      required this.repository,
      required this.textSearch,
      required this.onSearch})
      : super(key: key);

  @override
  State<HitagiSearch> createState() => _HitagiSearchState();
}

class _HitagiSearchState extends State<HitagiSearch> {
  final TextEditingController _textEditing = TextEditingController();
  AnilistEntity? _content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 350,
            child: TextField(
              strutStyle: const StrutStyle(height: 1.0, leading: 1),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                hintText: widget.textSearch,
                hintStyle: const TextStyle(
                  color: Color.fromARGB(65, 0, 0, 0),
                ),
                filled: true,
                fillColor: Colors.transparent,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              controller: _textEditing,
              onSubmitted: (value) {
                _searchManga(value);
              },
            ),
          ),
          const SizedBox(height: 20),
          if (_content != null)
            ListTile(
              title: Text(
                _content!.review.first.title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                _content!.media.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              leading: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(_content!.media.coverImage),
              ),
              onTap: () {},
            ),
        ],
      ),
    );
  }

  Future<void> _searchManga(String title) async {
    setState(() {
      _content = null;
    });
    try {
      final manga = await widget.repository.searchManga(title: title);
      setState(() {
        _content = manga;
      });
    } catch (error) {
      error;
    }
  }

  @override
  void dispose() {
    _textEditing.dispose();
    super.dispose();
  }
}
