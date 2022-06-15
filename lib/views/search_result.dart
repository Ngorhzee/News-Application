import 'package:flutter/material.dart';
import 'package:news_app/models/get_news.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/widget/card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.keyword}) : super(key: key);
  final  List<Map<String,dynamic>> keyword;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Map<String,dynamic>> newsList=[];
  GetNews getNews=GetNews();
  @override


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 50,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: const Center(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  
                  Text(
                    'Search Returned',
                    style: kTitleStyle,
                    textAlign: TextAlign.center,
                  ),
        ]),
            ),
          ),
         const Divider(
            thickness: 3,
            color: Colors.grey,
            
          ),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(children: [
                  ...List.generate(
                      widget.keyword.length,
                      (index) => GestureDetector(
                          onTap: (() {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewsScreen(
                                  image: widget.keyword[index]['image_url'],
                                  title: widget.keyword[index]['title'],
                                  content: widget.keyword[index]['content'],
                                  author: widget.keyword[index]['creator'][0],
                                  date: widget.keyword[index]['pubDate']);
                            }));
                          }),
                          child: CardWidget(
                              image: widget.keyword[index]['image_url'],
                              title: widget.keyword[index]['title'],
                              date: widget.keyword[index]['pubDate'],
                              time: widget.keyword[index]['pubDate'])))
                ]),
              )
            ],
          ))
        ]),
      ),
    );
  }
}
