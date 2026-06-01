class Favorite {
  final int movieId;
  final String image;
  final bool favorite;
  final String title;
  final String overview;
  final double popularity;
  final DateTime releaseDate;

  const Favorite({
    required this.movieId,
    required this.image,
    required this.favorite,
    required this.title,
    required this.overview,
    required this.popularity,
    required this.releaseDate,
  });

  Favorite copyWith({
    int? movieId,
    String? image,
    bool? favorite,
    String? title,
    String? overview,
    double? popularity,
    DateTime? releaseDate,
  }) {
    return Favorite(
      movieId: movieId ?? this.movieId,
      image: image ?? this.image,
      favorite: favorite ?? this.favorite,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      popularity: popularity ?? this.popularity,
      releaseDate: releaseDate ?? this.releaseDate,
    );
  }
}