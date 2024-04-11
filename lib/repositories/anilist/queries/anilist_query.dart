class Query {
  static String anilistQuery({required String title}) {
    return '''
 query  {
  Media(search: "$title") {
    id
    bannerImage
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
}
