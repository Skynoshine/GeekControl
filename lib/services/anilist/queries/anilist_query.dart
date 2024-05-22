class Query {
  static String ratedsQuery() {
    return '''
{
  Page {
    media(sort: POPULARITY_DESC, type: ANIME) {
      id
      averageScore
      meanScore
      coverImage {
        large
        extraLarge
      }
      type
      title {
        english
        romaji
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
        airingAt
        episode
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
      staff {
				edges {
          role
          node {
            name {
              full
            }
          }
        }
      }
    }
  }
}
    ''';
  }
}
