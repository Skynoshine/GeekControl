import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/spoilers/entities/spoiler_entity.dart';
import 'package:geekcontrol/animes/spoilers/pages/complete_spoilers_page.dart';
import 'package:geekcontrol/services/webscraper/spoilers_scraper.dart';
import 'package:go_router/go_router.dart';

class SpoilersPage extends StatefulWidget {
  const SpoilersPage({super.key});

  @override
  State<SpoilersPage> createState() => _SpoilersPageState();
}

class _SpoilersPageState extends State<SpoilersPage> {
  late List<SpoilersEntity> _spoilersList = [];
  late bool _isLoading = false;
  final SpoilersScrap _spoilersScrap = SpoilersScrap();

  @override
  void initState() {
    super.initState();
    _loadSpoilers();
  }

  Future<void> _loadSpoilers() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final List<SpoilersEntity> spoilers = await _spoilersScrap.getSpoilers();
      setState(() {
        _spoilersList = spoilers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }
  void _reloadSpoilers() {
    _loadSpoilers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).go('/'),
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Spoilers'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : AnimatedList(
                initialItemCount: _spoilersList.length,
                itemBuilder: (context, index, animation) {
                  final spoiler = _spoilersList[index];
                  return _buildSpoilerCard(spoiler, animation);
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _reloadSpoilers,
        child: const Icon(Icons.refresh),
      ),
    );
  }

  Widget _buildSpoilerCard(
      SpoilersEntity spoiler, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SpoilersDetailPage(spoiler: spoiler),
            )),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  spoiler.imageUrl!,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  '${spoiler.category} - ${spoiler.date}',
                  style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 4, 46, 80)),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  spoiler.title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  spoiler.content,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
