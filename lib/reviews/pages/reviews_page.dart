import 'package:flutter/material.dart';
import 'package:geekcontrol/services/anilist/entities/manga_anilist_entity.dart';
import 'package:geekcontrol/services/anilist/entities/reviews_entity.dart';

class ReviewsPage extends StatefulWidget {
  final List<MangaReviewEntity> reviews;
  final List<AnilistEntity> mangasAnilist;

  const ReviewsPage(
      {super.key, required this.reviews, required this.mangasAnilist});

  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 7, 7, 7),
        surfaceTintColor: Colors.amber,
        leading: BackButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {},
        ),
        backgroundColor: const Color.fromARGB(207, 0, 0, 0),
        title: TextButton.icon(
          onPressed: null,
          icon: const Icon(
            Icons.reviews,
            size: 30,
            color: Colors.white,
          ),
          label: Text(
            widget.reviews.isNotEmpty
                ? 'Reviews - ${widget.reviews.first.title}'
                : 'Reviews',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Image.network(widget.reviews.first.userReviews.bannerImage),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.reviews.length,
              itemBuilder: (context, index) {
                final review = widget.reviews[index];
                IconData starIcon = Icons.star;

                if (review.score >= 70) {
                  starIcon = Icons.star;
                } else if (review.score >= 45 && review.score < 70) {
                  starIcon = Icons.star_half;
                } else {
                  starIcon = Icons.star_border;
                }

                return ListTile(
                  title: Text(review.userReviews.name),
                  subtitle: Text(review.summary),
                  subtitleTextStyle: const TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                  trailing: TextButton.icon(
                    onPressed: null,
                    icon: Icon(
                      starIcon,
                      color: Colors.amber,
                    ),
                    label: Text('Rating: ${review.score}'),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: const Color.fromARGB(64, 204, 90, 90),
                    backgroundImage: NetworkImage(
                      review.userReviews.avatar,
                    ),
                  ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
