import '../../../core/utils/convert_state.dart';
import '../../../core/utils/entity_mappers.dart';

class ReleasesAnilistEntity {
  final int id;
  final int episodeId;
  final String englishTitle;
  final String bannerImage;
  final String coverImage;
  final int episodes;
  final int? actuallyEpisode;
  final int updatedAt;
  final String status;
  final String season;
  final int seasonYear;
  final String author;
  final String artist;
  final int? nextEpisode;
  final int airingAt;
  final Map<String, dynamic> startDate;
  final Map<String, dynamic>? endDate;

  ReleasesAnilistEntity({
    required this.id,
    required this.episodeId,
    required this.englishTitle,
    required this.bannerImage,
    required this.coverImage,
    required this.episodes,
    required this.updatedAt,
    required this.status,
    required this.season,
    required this.seasonYear,
    required this.startDate,
    required this.endDate,
    required this.author,
    required this.artist,
    required this.nextEpisode,
    required this.airingAt,
    required this.actuallyEpisode,
  });

  static List<ReleasesAnilistEntity> toEntityList(Map<String, dynamic> json) {
    final List<dynamic> mediaList = json['data']['Page']['media'];
    List<ReleasesAnilistEntity> entities = mediaList.map((media) {
      return ReleasesAnilistEntity(
        id: media['id'],
        episodeId: media['id'],
        englishTitle: media['title']?['english'] ?? '',
        episodes: media['episodes'] ?? 0,
        updatedAt: media['updatedAt'] ?? 0,
        status: MangaStates.toPortuguese(media['status'] ?? ''),
        season: media['season'] ?? '',
        seasonYear: media['seasonYear'] ?? 0,
        startDate: media['startDate'] ?? {},
        endDate: media['endDate'] ?? {},
        bannerImage: media['bannerImage'] ?? media['coverImage']['extraLarge'],
        coverImage: media['coverImage']['extraLarge'] ?? '',
        author:
            EntityMappers.roleEntity(media)?['node']?['name']?['full'] ?? 'N/A',
        artist: '',
        nextEpisode: media['nextAiringEpisode']?['episode'] ?? 0,
        airingAt: media['nextAiringEpisode']?['airingAt'] ?? 0,
        actuallyEpisode: EntityMappers.episodes(media),
      );
    }).toList();
    return entities;
  }

  ReleasesAnilistEntity.empty()
      : id = 0,
        nextEpisode = 0,
        airingAt = 0,
        episodeId = 0,
        englishTitle = '',
        bannerImage = '',
        coverImage = '',
        episodes = 0,
        updatedAt = 0,
        status = '',
        season = '',
        seasonYear = 0,
        startDate = {},
        author = '',
        artist = '',
        actuallyEpisode = 0,
        endDate = {};
}
