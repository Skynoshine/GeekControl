import 'package:flutter/material.dart';
import 'package:geekcontrol/animes/articles/entities/articles_entity.dart';

class ArticleCard extends StatelessWidget {
  final ArticlesEntity news;
  final bool isRead;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const ArticleCard({
    super.key,
    required this.news,
    required this.isRead,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Card(
        elevation: 4,
        color: isRead ? const Color.fromARGB(255, 240, 206, 206) : null,
        margin: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isRead)
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Icon(Icons.menu_book),
                ),
              ),
            Hero(
              tag: news.title,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  news.imageUrl!,
                  fit: BoxFit.cover,
                  height: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Por ${news.author} | ${news.date}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
