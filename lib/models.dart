class Movie {
  final int movieId;
  final String title;
  final int releaseYear;
  final int runtimeMins;
  final String rating;
  final String posterUrl;
  final String genres;

  Movie({
    required this.movieId,
    required this.title,
    required this.releaseYear,
    required this.runtimeMins,
    required this.rating,
    required this.posterUrl,
    required this.genres,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movie_id'] ?? 0,
      title: json['title'] ?? '',
      releaseYear: json['release_year'] ?? 0,
      runtimeMins: json['runtime_mins'] ?? 0,
      rating: json['rating']?.toString() ?? '0.0',
      posterUrl: json['poster_url'] ?? '',
      genres: json['genres'] ?? '',
    );
  }
}

List<Movie> Movies = [];
List<Map<String, dynamic>> Genres = [];
