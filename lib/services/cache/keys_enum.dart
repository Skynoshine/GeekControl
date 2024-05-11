enum CacheKeys {
  releases(key: 'releases'),
  favorites(key: 'favorites'),
  reads(key: 'reads'),
  articles(key: 'articles');

  final String key;

  const CacheKeys({required this.key});
}
