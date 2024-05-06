import 'package:geekcontrol/services/repositories/anilist/entities/reviews_entity.dart';

class AnilistEntity {
  final int id;
  final String name;
  final List<String> genres;
  final AnilistMediaEntity media;
  final List<MangaReviewEntity> review;

  AnilistEntity({
    required this.id,
    required this.name,
    required this.media,
    required this.review,
    required this.genres,
  });

  factory AnilistEntity.toEntity(Map<String, dynamic> json) {
    List<dynamic> genresJson = json['data']['Media']['genres'];

    List<String> genresList =
        genresJson.map((genre) => genre.toString()).toList();
    return AnilistEntity(
      id: json['data']['Media']['id'],
      name: json['data']['Media']['title']['english'],
      genres: genresList,
      media: AnilistMediaEntity.toEntity(json),
      review: MangaReviewEntity.toEntityList(json),
    );
  }

  AnilistEntity.empty()
      : id = 0,
        name = '',
        genres = [],
        media = AnilistMediaEntity.empty(),
        review = [MangaReviewEntity.empty()];
}

class AnilistMediaEntity {
  int id;
  String banner;
  String coverImage;
  String title;
  String description;
  String type;

  AnilistMediaEntity({
    required this.id,
    required this.banner,
    required this.coverImage,
    required this.title,
    required this.description,
    required this.type,
  });

  factory AnilistMediaEntity.toEntity(Map<String, dynamic> json) {
    final Map<String, dynamic> media = json['data']['Media'];
    return AnilistMediaEntity(
      id: media['id'],
      banner: media['bannerImage'],
      coverImage: media['coverImage']['large'],
      title: media['title']['english'],
      description: media['description'],
      type: media['type'],
    );
  }

  AnilistMediaEntity.empty()
      : id = 0,
        banner = '',
        coverImage = '',
        title = '',
        description = '',
        type = '';
}

class CharactersAnilistEntity {
  String characterName;
  String largeImage;
  String mediumImage;
  String gender;
  String age;

  CharactersAnilistEntity(
      {required this.characterName,
      required this.largeImage,
      required this.mediumImage,
      required this.gender,
      required this.age});

  factory CharactersAnilistEntity.fromJson(Map<String, dynamic> json) {
    return CharactersAnilistEntity(
      characterName: json[''],
      largeImage: json[''],
      mediumImage: json[''],
      gender: json[''],
      age: json[''],
    );
  }

  CharactersAnilistEntity.empty()
      : characterName = '',
        largeImage = '',
        mediumImage = '',
        gender = '',
        age = '';
}
