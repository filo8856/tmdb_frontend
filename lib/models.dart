import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

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

class BookmarkStorage {
  static const _key = "bookmarked_movies";

  static final FlutterSecureStorage _storage = FlutterSecureStorage();

  // 🔹 Get bookmarks
  static Future<List<String>> getBookmarks() async {
    final data = await _storage.read(key: _key);

    if (data == null) return [];

    final List<dynamic> decoded = jsonDecode(data);
    return decoded.map((e) => e.toString()).toList();
  }

  // 🔹 Save full list
  static Future<void> saveBookmarks() async {
    final encoded = jsonEncode(bookmarked);
    await _storage.write(key: _key, value: encoded);
  }
}

List<Movie> Movies = [];
List<Map<String, dynamic>> Genres = [];
List<String> bookmarked = [];
