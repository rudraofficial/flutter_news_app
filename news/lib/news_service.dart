import 'dart:convert';
import 'package:http/http.dart' as http;

class NewsService {
  final String apiKey = '0ddedbe25a284afdaa9dab2c1f089d86';
  final String baseUrl = 'https://newsapi.org/v2';

  Future<List<NewsArticle>> fetchNews(String country) async {
    final url = Uri.parse('$baseUrl/top-headlines?country=$country&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      final articles = parsed['articles'] as List<dynamic>;
      return articles.map((json) => NewsArticle.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}

class NewsArticle {
  final String title;
  final String description;
  final String url;

  NewsArticle({
    required this.title,
    required this.description,
    required this.url,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
    );
  }
}
