import 'package:assign_final/models/category_model.dart';
import 'package:assign_final/models/healine_model.dart';
import 'package:assign_final/repos/news_repo.dart';

class NewsViewModel {
  final _repo = NewsRepository();

//view model for healines news method

  Future<HeadlinesModel> getHeadlines(String channelName) async {
    final response = await _repo.getHeadlines(channelName);

    return response;
  }

  //view model for news category
  Future<CategoryModel> getCategoryNews(String categoryName) async {
    final response = await _repo.getCategoryNews(categoryName);

    return response;
  }
}
