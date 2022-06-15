// ignore_for_file: avoid_print

import 'dart:math';


import 'package:flutter/material.dart';
import 'package:news_app/models/get_news.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/views/search_screen.dart';
import 'package:news_app/widget/breakingnews_card.dart';
import 'package:news_app/widget/card.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../tab_views/tabs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  final List<Map<String, dynamic>> news = [];
  final now = DateTime.now().day.toString() +
      '/' +
      DateTime.now().month.toString() +
      '/' +
      DateTime.now().year.toString();
  GetNews getNews = GetNews();
  Random random = Random();
  late int randomNumber = random.nextInt(5);
  List<String> tabList = [
    'Top',
    'Sports',
    'Entertainment',
    'Business',
    'Politics',
    'Technology'
  ];
  @override
  void initState() {
    super.initState();
    //getNewss();

    setState(() {
      getNewss();
    });
  }

  getNewss() async {
    setState(() {
      
    });
    news.addAll(await getNews.getNews());
    print(news);
    setState(() {
      
    });
    return news;
  }

  getNewsByCategories(String cate) async {
    setState(() {
      
    });
    news.addAll(await getNews.getCategories(cate));
    print(news);
    setState(() {
      
    });
    return news;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBackgroundColor2,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:news.isEmpty? Center(child: CircularProgressIndicator(color:kActiveCategoriesColor)):
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Text(
                        now,
                        style: kDateStyle,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: ((context) => const SearchView())));
                        },
                        icon: const Icon(
                          Icons.search_outlined,
                          size: 30,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: CustomScrollView(slivers: [
                      SliverToBoxAdapter(
                        child: Text(
                          'Breaking News',
                          style: kHealineStyle,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: GestureDetector(
                            onTap: (() {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return NewsScreen(
                                    image: news[randomNumber]['image_url'],
                                    title: news[randomNumber]['title'],
                                    content: news[randomNumber]['content'],
                                    author: news[randomNumber]['creator'][0],
                                    date: news[randomNumber]['pubDate']);
                              })));
                            }),
                            child: news.isEmpty
                                ? Container(
                                    color: Colors.red,
                                    height: 30,
                                  )
                                : BreakingNews(
                                    image: news[randomNumber]['image_url'],
                                    title: news[randomNumber]['title'],
                                    date: news[randomNumber]['pubDate'],
                                    author: news[randomNumber]['creator'][0],
                                  )),
                      ),
                      const SliverToBoxAdapter(
                        child: SizedBox(height: 20),
                      ),
                      SliverPinnedHeader(
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                ...List.generate(
                                    tabList.length,
                                    (index) => GestureDetector(
                                          onTap: () {
                                            selectedIndex = index;
                                            news.clear();
                                            setState(() {});
                                            Future.delayed(
                                                const Duration(
                                                  seconds: 1,
                                                ),
                                                (() => getNewsByCategories(
                                                    tabList[selectedIndex])));
                                            //setState(() {});
                                          },
                                          child: Tabs(
                                            text: tabList[index],
                                            icon: index == selectedIndex
                                                ? Icons.circle
                                                : null,
                                            color: index == selectedIndex
                                                ? kActiveCategoriesColor
                                                : kInactiveCategoriesColor,
                                          ),
                                        )),
                              ],
                            )),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            ...List.generate(
                                news.length,
                                (index) => GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: ((context) {
                                            return NewsScreen(
                                                image: news[index]
                                                    ['image_url'],
                                                title: news[index]
                                                    ['title'],
                                                content: news[index]
                                                    ['content'],
                                                author: news[index]
                                                    ['creator'][0],
                                                date: news[index]
                                                    ['pubDate']);
                                          }),
                                        ),
                                      );
                                    },
                                    child: news.isEmpty
                                        ? Container(
                                            color: Colors.pink,
                                            height: 100,
                                          )
                                        : CardWidget(
                                            image: news[index]['image_url'],
                                            title: news[index]['title'],
                                            date: news[index]['pubDate'],
                                            time: news[index]['pubDate'],
                                          )))
                          ],
                        ),
                      )
                    ]),
                  )
                ]),
          ),
        ));
  }
}
//news[randomNumber]['image_url'] ??
//news[randomNumber]['title']
//news[randomNumber]['creator'].toString()