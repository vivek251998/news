import 'dart:convert';
import 'package:http/http.dart' as http;
import 'article_model.dart';

class NewsService {
  static const String _apiKey = 'b347d30488d546eb8f5db7a2844af97b';
  static const String _baseUrl = 'https://newsapi.org/v2';

  static Future<List<Article>> fetchNewss() async {
    final response = await http.get(Uri.parse(
        // '$_baseUrl/top-headlines?country=in&category=$category&page=$page&pageSize=20&apiKey=$_apiKey',
        "https://newsapi.org/v2/everything?q=all&from=2025-07-04&sortBy=popularity&apiKey=80881a0e8d414414837e2f690e035834"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  static Future<List<Article>> fetchNews(String category, int page) async {
    final response = await http.get(Uri.parse(
        // '$_baseUrl/top-headlines?country=in&category=$category&page=$page&pageSize=20&apiKey=$_apiKey',
        "https://newsapi.org/v2/everything?q=$category&from=2025-07-04&sortBy=popularity&apiKey=80881a0e8d414414837e2f690e035834"));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  static Future<List<Article>> searchNews(String query) async {
    final response = await http.get(Uri.parse(
      'https://newsapi.org/v2/everything?q=$query&from=2025-07-04&sortBy=popularity&apiKey=80881a0e8d414414837e2f690e035834',
      // '$_baseUrl/everything?q=$query&pageSize=20&apiKey=$_apiKey',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['articles'] as List)
          .map((e) => Article.fromJson(e))
          .toList();
    } else {
      throw Exception('Failed to search news');
    }
  }
}
