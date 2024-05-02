class ArticlesEntity {
  final String title;
  final String? imageUrl;
  final String date;
  final String author;
  final String category;
  final String content;
  final String url;
  final String? sourceUrl;

  ArticlesEntity({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.category,
    required this.content,
    required this.url,
    required this.sourceUrl,
  });
}
