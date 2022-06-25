
import 'package:news_app/models/get_news.dart';

class NewsFunctions{
  List<Map<String, dynamic>> newsList = [];
  List<Map<String, dynamic>> searchNews = [];
 static List<Map<String, dynamic>> favouriteList = [];
 
  GetNews news=GetNews();

  getNews(String categories)async{
    newsList.addAll(await news.getCategories(categories));
  }
  getNewss()async{
    newsList.addAll(await news.getNews());
  }
  getNewsByKeyword(String keyWord)async{
    searchNews.addAll(await news.getByKeyword(keyWord));
  }
  
  addfavouriteNews(Map<String, dynamic> item)async{
    favouriteList.add(item);
  }
  removefavouriteNews(Map<String, dynamic> item)async{
    favouriteList.remove(item);
  }

 
}