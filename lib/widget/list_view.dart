// import 'package:flutter/material.dart';
// import 'package:news_app/models/get_news.dart';
// import 'package:news_app/models/service.dart';
// import 'package:news_app/widget/card.dart';

// import '../models/articles.dart';

// class View extends StatelessWidget {
//    View({ Key? key,this.articles }) : super(key: key);
//   //final int index;
//   var articles;
//   GetNews getNews=GetNews();

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: ListView.builder(
//                             itemCount: ,
//                             itemBuilder: (context, index) {
                              
//                               Article article = articles[index];
//                               return Column(
//                                 children: [
//                                   SizedBox(height: 20),
//                                   CardWidget(
//                                       article: article,),
//                                   //Page1_widget(picture: datamodel.image,title: datamodel.title,writter: datamodel.author,date: datamodel.date),
//                                 ],
//                               );
//                             }),
//     );
//   }
// }