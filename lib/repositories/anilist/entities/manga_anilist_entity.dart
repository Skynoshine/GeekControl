import 'package:myapp/repositories/anilist/entities/reviews_entity.dart';

class AnilistEntity {
  final int id;
  final String name;
  final AnilistMediaEntity media;
  final List<MangaReviewEntity> review;

  AnilistEntity({
    required this.id,
    required this.name,
    required this.media,
    required this.review,
    // required this.characters,
  });

  factory AnilistEntity.toEntity(Map<String, dynamic> json) {
    return AnilistEntity(
      id: json['data']['Media']['id'],
      name: json['data']['Media']['title']['english'],
      media: AnilistMediaEntity.fromJson(json),
      review: MangaReviewEntity.toEntityList(json),
    );
  }

  AnilistEntity.empty()
      : id = 0,
        name = '',
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

  factory AnilistMediaEntity.fromJson(Map<String, dynamic> json) {
    return AnilistMediaEntity(
      id: json['data']['Media']['id'],
      banner: json['data']['Media']['bannerImage'],
      coverImage: json['data']['Media']['coverImage']['large'],
      title: json['data']['Media']['title']['english'],
      description: json['data']['Media']['description'],
      type: json['data']['Media']['type'],
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
