enum CacheKeys {
  releases(key: 'releases'),
  favorites(key: 'favorites'),
  reads(key: 'reads'),
  anilist(key: 'anilist'),
  articles(key: 'articles'),
  rates(key: 'rates');

  final String key;

  const CacheKeys({required this.key});
}
