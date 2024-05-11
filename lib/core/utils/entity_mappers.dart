class EntityMappers {
  static Map<String, dynamic>? roleEntity(Map<String, dynamic> media) {
    return (media['staff']['edges'] as List).firstWhere(
        (e) =>
            e['role'] == 'Original Creator' ||
            e['role'] == 'Original Story' ||
            e['role'] == 'Series Composition',
        orElse: () => null);
  }

  static int episodes(Map<String, dynamic> media) {
    final episode = media['nextAiringEpisode']?['episode'] ?? 0;

    if (episode == null || episode < 1) {
      return 0;
    } else {
      return episode - 1;
    }
  }
}
