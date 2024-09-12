import 'dart:convert';

import 'package:assign_final/models/category_model.dart';
import 'package:assign_final/models/healine_model.dart';
import 'package:http/http.dart' as http;

class NewsRepository {
  //api key
  String key = "093c6a9bc5df4111ba5fc7d35ec585ca";

  //featching top headlines from certain channel
  Future<HeadlinesModel> getHeadlines(String channelName) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$channelName &apiKey=$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final body = jsonDecode(response.body);

        return HeadlinesModel.fromJson(body);
      } catch (e) {
        throw Exception(e);
      }
    }
    throw Exception('error connecting to api');
  }

  //fetching news according to category

  Future<CategoryModel> getCategoryNews(String categoryName) async {
    String url =
        'https://newsapi.org/v2/everything?q= $categoryName &apiKey=$key';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        final body = jsonDecode(response.body);

        return CategoryModel.fromJson(body);
      } catch (e) {
        throw Exception(e);
      }
    }
    throw Exception('error occurred');
  }
}
