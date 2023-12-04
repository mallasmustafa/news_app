import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadlinesModel> fatchNewsChannelHeadlinesApi(
      String newsChannel) async {
    final response =
        await NewsRepository().fatchNewsChannelHeadlinesApi(newsChannel);
    return response;
  }
  Future<CategoriesNewsModel> fatchCategoriesNewsApi(
      String category) async {
    final response =await NewsRepository().fatchCategoriesNewsApi(category);
    return response;
  }
}
