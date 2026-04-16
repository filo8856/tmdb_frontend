import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tmdb/models.dart';

class ApiService {
  static const String baseUrl =
      "https://movie-database-backend-cyvf.onrender.com";

  static Future<List<Movie>> fetchMovies() async {
    final response = await http.get(Uri.parse('$baseUrl/movies/'));

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  static Future<Map<String, dynamic>> fetchMovieById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/movies/$id'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body); // ✅ already a Map
    } else {
      throw Exception('Failed to load movie');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchGen() async {
    final response = await http.get(Uri.parse('$baseUrl/genres'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);

      return List<Map<String, dynamic>>.from(
        data.map((e) => Map<String, dynamic>.from(e)),
      );
    } else {
      throw Exception('Failed to load genres');
    }
  }

  static Future<List<int>> aiSearchIds(String question) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ai/search'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"question": question}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List results = data['results'];

      return results.map((e) => e['movie_id'] as int).toList();
    } else {
      throw Exception('AI search failed');
    }
  }
}

Map<String, List<Movie>> groupMoviesByGenre() {
  Map<String, List<Movie>> genreMap = {};

  // 🧱 Initialize using genre_name
  for (var g in Genres) {
    final genreName = g['genre_name'];
    genreMap[genreName] = [];
  }

  // 🔁 Fill map
  for (var movie in Movies) {
    final movieGenres = movie.genres.split(',');

    for (var g in movieGenres) {
      final genre = g.trim();

      if (genreMap.containsKey(genre)) {
        genreMap[genre]!.add(movie);
      }
    }
  }

  return genreMap;
}
