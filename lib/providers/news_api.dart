import 'dart:convert';

import 'package:to_do_list/models/news.dart';
import 'package:http/http.dart' as http;

class NewsApi{
  static String apiUri = 'https://newsapi.org/v2/top-headlines?country=kr&apiKey=';
  static String apiKey = '1a2ed3dc9e914338a98b7fe5e7a27af1';
  Uri uri = Uri.parse(apiUri + apiKey);

  Future<List<News>> getNews() async{
    List<News> news = [];
    final response = await http.get(uri);
    final statusCode = response.statusCode;
    final body = response.body;

    if(statusCode == 200){
      news = jsonDecode(body)['articles'].map<News>((article){
        return News.fromMap(article);
      }).toList();
    }
    return news;
  }
}