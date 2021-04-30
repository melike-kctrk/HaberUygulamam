import 'dart:convert';
import 'package:haberuygulamam/models/article.dart';
import 'package:haberuygulamam/models/news.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static NewsService _singleton = NewsService._internal();
  NewsService._internal();

  factory NewsService() {
    return _singleton;
  }

  static Future<List<Articles>?> getNews() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=tr&category=business&apiKey=f58b94449b4f45b9844a296497a93747';

    final response = await http.get(Uri.parse(url));
    print('object');
    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      News news = News.fromJson(responseJson);
      print(responseJson);
      return news.articles;
    }
    return null;
  }
}
