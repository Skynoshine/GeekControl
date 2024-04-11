class MangaReviewEntity {
  int idPost;
  int userId;
  int mediaId;
  String summary;
  int rating;
  int ratingAmoung;
  String userRating;
  int score;
  String siteUrl;
  String title;
  int createdAt;
  int updatedAt;
  UserReviews userReviews;

  MangaReviewEntity({
    required this.idPost,
    required this.userId,
    required this.mediaId,
    required this.summary,
    required this.rating,
    required this.ratingAmoung,
    required this.userRating,
    required this.score,
    required this.siteUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.userReviews,
    required this.title,
  });

  static List<MangaReviewEntity> toEntityList(Map<String, dynamic> json) {
    final edges = json['data']['Media']['reviews']['edges'];
    List<MangaReviewEntity> reviewsList = [];

    for (int i = 0; i < edges.length; i++) {
      final edge = edges[i];
      if (edge != null && edge.containsKey('node')) {
        final node = edge['node'];
        reviewsList.add(MangaReviewEntity(
          idPost: node['id'],
          title: json['data']['Media']['title']['english'],
          userId: node['userId'],
          mediaId: node['mediaId'],
          summary: node['summary'],
          rating: node['rating'],
          ratingAmoung: node['ratingAmount'],
          userRating: node['userRating'],
          score: node['score'],
          siteUrl: node['siteUrl'],
          createdAt: node['createdAt'],
          updatedAt: node['updatedAt'],
          userReviews: UserReviews.fromJson(node),
        ));
      }
    }

    return reviewsList;
  }

  MangaReviewEntity.empty()
      : idPost = 0,
        userId = 0,
        mediaId = 0,
        summary = '',
        rating = 0,
        ratingAmoung = 0,
        userRating = '',
        score = 0,
        siteUrl = '',
        createdAt = 0,
        updatedAt = 0,
        title = '',
        userReviews = UserReviews.empty();
}

class UserReviews {
  String body;
  String name;
  String avatar;
  String bannerImage;

  UserReviews({
    required this.body,
    required this.name,
    required this.avatar,
    required this.bannerImage,
  });

  factory UserReviews.fromJson(Map<String, dynamic> json) {
    return UserReviews(
      body:  json['body'] ?? 'N/A',
      name: json['user']['name'],
      avatar: json['user']['avatar']['large'] ?? '',
      bannerImage: json['user']['bannerImage'] ?? '',
    );
  }

  UserReviews.empty()
      : body = '',
        name = '',
        avatar = '',
        bannerImage = '';
}
