class MangasRates {
  String title;
  int meanScore;
  int averageScore;
  String coverImage;
  String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  MangasRates({
    required this.title,
    required this.meanScore,
    required this.averageScore,
    required this.status,
    required this.coverImage,
    required this.createdAt,
    required this.updatedAt,
  });

  static List<MangasRates> toEntityList(Map<String, dynamic> json) {
    final List<dynamic> mediaList = json['data']['Page']['media'];
    List<MangasRates> entities = mediaList.map((media) {
      return MangasRates(
        title: media?['title']['english'] ?? '',
        coverImage:
            media?['coverImage']['large'] ?? media?['coverImage']['extraLarge'],
        meanScore: media?['meanScore'] ?? 0,
        averageScore: media?['averageScore'] ?? 0,
        status: media?['status'] ?? '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
    }).toList();
    return entities;
  }

  static MangasRates fromMap(Map<String, dynamic> map) {
    return MangasRates(
      title: map['title']['english'] ?? '',
      coverImage: map['coverImage']['large'] ?? map['coverImage']['extraLarge'],
      meanScore: map['meanScore'] ?? 0,
      averageScore: map['averageScore'] ?? 0,
      status: map['status'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'meanScore': meanScore,
      'averageScore': averageScore,
      'coverImage': coverImage,
      'status': status,
    };
  }

  MangasRates.empty()
      : title = '',
        meanScore = 0,
        averageScore = 0,
        status = '',
        createdAt = DateTime.now(),
        updatedAt = DateTime.now(),
        coverImage = '';
}
