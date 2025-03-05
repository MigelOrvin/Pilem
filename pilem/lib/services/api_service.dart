import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://api.themoviedb.org/3";
  static const String apikey = "daef2c04d79af87659dc1f62beb3d2af";

  Future<List<Map<String, dynamic>>> getAllMovies() async {
    final response = await http
        .get(Uri.parse("$baseUrl/movie/now_displaying?api_key=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getTrendingMovies() async {
    final response = await http
        .get(Uri.parse("$baseUrl/trending/movie/week?api_key=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> getPopularMovies() async {
    final response =
        await http.get(Uri.parse("$baseUrl/movie/popular?api_key=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }

  Future<List<Map<String, dynamic>>> searchMovies(String query) async {
    final response = await http
        .get(Uri.parse("$baseUrl/search/movie?query=$query&api_key=$apikey"));
    final data = json.decode(response.body);
    return List<Map<String, dynamic>>.from(data['result']);
  }
}
