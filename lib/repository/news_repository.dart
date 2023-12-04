import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';

class NewsRepository {
  Future<CategoriesNewsModel> fatchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=${category}&apiKey=f83c7864f4024e21a064bf59f5d992b1";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewsModel.fromJson(body);
    } else {
      throw Exception("Error");
    }
  }

  Future<NewsChannelsHeadlinesModel> fatchNewsChannelHeadlinesApi(
      String newsChannel) async {
    String newsUrl =
        "https://newsapi.org/v2/top-headlines?sources=${newsChannel}&apiKey=f83c7864f4024e21a064bf59f5d992b1";
    final response = await http.get(Uri.parse(newsUrl));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);
    }else {
      throw Exception("Error");
    }
  }
}
