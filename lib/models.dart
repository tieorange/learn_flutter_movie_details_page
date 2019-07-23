class Movie {
  var storyline;

//  final List<String> categories;

  Movie(
      {String bannerUrl,
      String posterUrl,
      String title,
      double rating,
      int starRating,
      List<String> categories,
      String storyline,
      List<String> photoUrls,
      List<Actor> actors});

//  final List<Actor> actors;
}

class Actor {
  Actor({
    this.name,
    this.avatarUrl,
  });

  final String name;
  final String avatarUrl;
}
