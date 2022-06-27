import 'package:flutter/material.dart';
import 'package:news_app/models/functions.dart';
import 'package:news_app/models/get_news.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/widget/card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.keyword}) : super(key: key);
  final List<Map<String, dynamic>> keyword;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  List<Map<String, dynamic>> newsList = [];
  GetNews getNews = GetNews();
  bool pressed = false;
  NewsFunctions functions = NewsFunctions();

  toggle() {
    pressed = !pressed;
  }

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
              child: Row(children: [
                GestureDetector(
                  onTap: () {
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
                          onTap: (() async {
                            bool press = await Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return NewsScreen(
                                pressed: pressed,
                                news: widget.keyword[index],
                                
                              );
                            }));
                            if (press == true || press == false) {
                              pressed = press;
                              setState(() {});
                            }
                          }),
                          child: CardWidget(
                              icon: pressed
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_outline,
                                      color: Colors.black,
                                    ),
                              onpress: () {
                                toggle();
                                if (pressed == false) {
                                  final snack = SnackBar(
                                    content: Text(
                                      'Removed from Favourite',
                                      style: kDateStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black,
                                    elevation: 5,
                                    duration: const Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);

                                  functions.removefavouriteNews(
                                      widget.keyword[index]);
                                } else {
                                  final snack = SnackBar(
                                    content: Text(
                                      'Added To Favourite',
                                      style: kDateStyle.copyWith(
                                          color: Colors.white),
                                    ),
                                    backgroundColor: Colors.black,
                                    elevation: 5,
                                    duration: const Duration(seconds: 2),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snack);

                                  functions.addfavouriteNews(
                                    widget.keyword[index]);
                                }
                              },
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
