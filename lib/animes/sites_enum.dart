enum SitesEnum {
  animesNew(key: 'animes_new'),
  intoxi(key: 'intoxi_animes'),
  defaultSite(key: 'animes_new');

  final String key;

  const SitesEnum({required this.key});
}