// ignore_for_file: avoid_print

import 'dart:convert';
import '../utilities/constants.dart';

import 'package:http/http.dart'as http;

class GetNews{
  Future<List<Map<String,dynamic>>> getNews()async{
    try{
      http.Response response=await http.get(Uri.parse("https://newsdata.io/api/1/news?apikey=$apiKey&country=ng"));
    
      final data=jsonDecode(response.body)["results"];
      final List<Map<String, dynamic>> newsList =
          List<Map<String, dynamic>>.from(
        data.map((e) => e),
      );
      
    
    return newsList;
    }
   catch(e){
     print('error');
     rethrow;
   }
    
  }
  Future<List<Map<String,dynamic>>> getCategories(String categories)async{
    try{
    http.Response response=await http.get(Uri.parse("https://newsdata.io/api/1/news?apikey=$apiKey&country=ng&category=$categories"));
    final data=jsonDecode(response.body)["results"];
      final List<Map<String, dynamic>> newsList =
          List<Map<String, dynamic>>.from(
        data.map((e) => e),
      );
   
    return newsList;
  }
  catch(e){
    rethrow;
  }
  
  }
  Future<List<Map<String,dynamic>>>getByKeyword(String keyWord)async {
    try{
      http.Response response=await http.get(Uri.parse('https://newsdata.io/api/1/news?apikey=$apiKey&q=$keyWord'));
      final data=jsonDecode(response.body)['results'];
      final List<Map<String,dynamic>>newsList=List<Map<String, dynamic>>.from(
        data.map((e) => e),
      );
      return newsList;
    }
    catch(e){
      rethrow;
    }
  }
  }