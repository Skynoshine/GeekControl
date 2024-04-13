
import 'package:geekcontrol/repositories/anilist/entities/manga_anilist_entity.dart';

class MangasController {
  double mediaReviews(List<AnilistEntity> anilist) {
    double media = 0.0;
    if (anilist.isNotEmpty) {
      double totalRating = 0.0;
      int totalReviews = 0;

      for (var anilistEntity in anilist) {
        for (var review in anilistEntity.review) {
          totalRating += review.rating;
          totalReviews++;
        }
      }

      if (totalReviews != 0) {
        media = totalRating / totalReviews;
      }
    }
    return media;
  }
}
