class ArticlesEntity {
  final String title;
  final String? imageUrl;
  final String date;
  final String author;
  final String category;
  final String content;
  final String url;
  final String? sourceUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  ArticlesEntity({
    required this.title,
    required this.imageUrl,
    required this.date,
    required this.author,
    required this.category,
    required this.content,
    required this.url,
    required this.sourceUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  List<String> toList() {
    return [
      title,
      imageUrl ?? '',
      date,
      author,
      category,
      content,
      url,
      sourceUrl ?? '',
    ];
  }

  static ArticlesEntity fromMap(Map<String, dynamic> map) {
    return ArticlesEntity(
      title: map['title'],
      imageUrl: map['imageUrl'],
      date: map['date'],
      author: map['author'],
      category: map['category'],
      content: map['content'],
      url: map['url'],
      sourceUrl: map['sourceUrl'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'imageUrl': imageUrl,
      'date': date,
      'author': author,
      'category': category,
      'content': content,
      'url': url,
      'sourceUrl': sourceUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
