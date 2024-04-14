class Query {
  static String abrangeQuery({required String title}) {
    return '''
 query  {
  Media(search: "$title") {
    id
    averageScore
    meanScore
    genres
    bannerImage
    status
    coverImage {
      large
      extraLarge
    }
    description
    type
    title {
      english
      romaji
      native
    }
    reviews{
      edges{
        node{
          id
          userId
          mediaId
          mediaType
          body
          summary
          rating
          ratingAmount
          userRating
          score
          siteUrl
          createdAt
          updatedAt
          user{
            name
            bannerImage
            avatar {
              large
            }
          }
        }
      }
    }
  }
}
    ''';
  }

  static String releasesQuery(String? title) {
    return '''
  query {
  Page {
    media(${title != null && title.isNotEmpty ? 'search: "$title"' : 'sort: TRENDING_DESC'}, type: ANIME) {
      id
      bannerImage
      coverImage {
        extraLarge
      }
      airingSchedule(notYetAired: true, perPage: 1) {
        nodes {
          episode
          id
          media {
            id
            bannerImage
            coverImage {
              extraLarge
            }
          }
        }
      }
      title {
        romaji
        english
      }
      episodes
      updatedAt
      status
      season
      seasonYear
      episodes
      nextAiringEpisode {
        id
      }
      startDate {
        year
        month
        day
      }
      endDate {
        year
        month
        day
      }

    }
  }
}
    ''';
  }
}
