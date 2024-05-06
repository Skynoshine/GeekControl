class ReleasesAnilistEntity {
  final int id;
  final int episodeId;
  final String englishTitle;
  final String bannerImage;
  final String coverImage;
  final int episodes;
  final int updatedAt;
  final String status;
  final String season;
  final int seasonYear;
  final String author;
  final String artist;
  final Map<String, dynamic>? nextAiringEpisode;
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
    required this.nextAiringEpisode,
    required this.startDate,
    required this.endDate,
    required this.author,
    required this.artist,
  });

  factory ReleasesAnilistEntity.toEntity(Map<String, dynamic> json) {
    final Map<String, dynamic> path = json['data']['Page']['media'][0];
    return ReleasesAnilistEntity(
      id: path['id'],
      englishTitle: path['title']['english'],
      episodes: path['episodes'],
      updatedAt: path['updatedAt'],
      status: path['status'],
      season: path['season'],
      seasonYear: path['seasonYear'],
      startDate: path['startDate'],
      endDate: path['endDate'] ?? {},
      bannerImage: path['bannerImage'],
      coverImage: path['coverImage']['extraLarge'],
      nextAiringEpisode: path['nextAiringEpisode'] ?? {},
      episodeId: path['id'],
      author: path['staff']['edges'][0]['node']['name']['full'],
      artist: path['staff']['edges'][1]['node']['name']['full'],
    );
  }

  ReleasesAnilistEntity.empty()
      : id = 0,
        episodeId = 0,
        englishTitle = '',
        bannerImage = '',
        coverImage = '',
        episodes = 0,
        updatedAt = 0,
        status = '',
        season = '',
        seasonYear = 0,
        nextAiringEpisode = {},
        startDate = {},
        author = '',
        artist = '',
        endDate = {};
}

class AiringSchedule {
  final int episodeAiring;
  final int episodeId;
  final String episodeBanner;
  final String episodeCover;

  AiringSchedule({
    required this.episodeAiring,
    required this.episodeId,
    required this.episodeBanner,
    required this.episodeCover,
  });

  factory AiringSchedule.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> path = json['Page']['media'];
    final Map<String, dynamic> airing = path['airingSchedule']['nodes'];
    return AiringSchedule(
      episodeAiring: airing['episode'],
      episodeId: json['id'],
      episodeBanner: json['bannerImage'],
      episodeCover: json['coverImage']['extraLarge'],
    );
  }

  AiringSchedule.empty()
      : episodeAiring = 0,
        episodeId = 0,
        episodeBanner = '',
        episodeCover = '';
}
