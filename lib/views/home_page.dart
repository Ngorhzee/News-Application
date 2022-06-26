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

import '../models/functions.dart';
import '../models/shared_pref.dart';
import '../tab_views/tabs.dart';
import 'favourite.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  NewsFunctions functions = NewsFunctions();
  final now = DateTime.now().day.toString() +
      '/' +
      DateTime.now().month.toString() +
      '/' +
      DateTime.now().year.toString();
  GetNews getNews = GetNews();
  Random random = Random();
  String category = 'Top';
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
    getNewss();
    getNewsByCategories(category);

    setState(() {
      //getNewss();
    });
  }

  getNewss() async {
    setState(() {});
    await functions.getNewss();
    setState(() {});
    //return functions.newsList;
  }

  getNewsByCategories(String cate) async {
    setState(() {});
    await functions.getNews(cate);
    setState(() {});
    // return functions.newsList;
  }

  bool pressed1 = false;
  bool pressed2 = false;
  toggle1() {
    setState(() {
      pressed1 = !pressed1;
    });
  }

  toggle2() {
    setState(() {
      pressed2 = !pressed2;
    });
  }

  int selectedIndex2 = 0;

  @override
  Widget build(BuildContext context) {
    //var pressed;
    return Scaffold(
        backgroundColor: kBackgroundColor2,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: functions.newsList.isEmpty
                ? Center(
                    child: CircularProgressIndicator(
                        color: kActiveCategoriesColor))
                : Column(
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
                              onPressed: () async {
                                StoreSearch storeSearch = StoreSearch();
                                List<String> searchValue =
                                    await storeSearch.storeSearch() ?? [];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) => SearchView(
                                          searchValue: searchValue,
                                        )),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.search_outlined,
                                size: 30,
                                color: Colors.grey,
                              ),
                            ),
                            GestureDetector(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: ((context) {
                                      return FavoriteScreen(
                                          favouriteList:
                                              NewsFunctions.favouriteList);
                                    }),
                                  ),
                                );
                              }),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Favourites',
                                    style: kDateStyle.copyWith(fontSize: 14),
                                  ),
                                ],
                              ),
                            )
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
                                  onTap: () async {
                                    bool pressed = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: ((context) {
                                          return NewsScreen(
                                            pressed: pressed1,
                                              news: functions
                                                  .newsList[randomNumber],
                                              image: functions
                                                      .newsList[randomNumber]
                                                  ['image_url'],
                                              content: functions
                                                      .newsList[randomNumber]
                                                  ['content'],
                                              title: functions
                                                      .newsList[randomNumber]
                                                  ['title'],
                                              link: functions
                                                      .newsList[randomNumber]
                                                  ['link'],
                                              author: functions
                                                      .newsList[randomNumber]
                                                  ['creator'][0],
                                              date:
                                                  functions.newsList[randomNumber]
                                                      ['pubDate']);
                                        }),
                                      ),
                                    );
                                    print(pressed);
                                    if (pressed == true || pressed == false) {
                                      pressed1 = pressed;
                                      setState(() {});
                                    }
                                  },
                                  child: functions.newsList.isEmpty
                                      ? Container(
                                          color: Colors.red,
                                          height: 30,
                                        )
                                      : BreakingNews(
                                          icon: pressed1
                                              // ignore: dead_code
                                              ? const Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                )
                                              : const Icon(
                                                  Icons.favorite_outline,
                                                  color: Colors.black,
                                                ),
                                          onpress: () {
                                            bool press;
                                            toggle1();
                                            //print(pressed);

                                            //pressed = true;
                                            if (pressed1 == true) {
                                              final snack = SnackBar(
                                                content: Text(
                                                  'Added to Favourite',
                                                  style: kDateStyle.copyWith(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: Colors.black,
                                                elevation: 5,
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snack);

                                              functions.addfavouriteNews(
                                                  functions
                                                      .newsList[randomNumber]);
                                            } else {
                                              final snack = SnackBar(
                                                content: Text(
                                                  'Removed from Favourite',
                                                  style: kDateStyle.copyWith(
                                                      color: Colors.white),
                                                ),
                                                backgroundColor: Colors.black,
                                                elevation: 5,
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snack);

                                              functions.addfavouriteNews(
                                                  functions
                                                      .newsList[randomNumber]);
                                            }
                                          },
                                          image:
                                              functions.newsList[randomNumber]
                                                  ['image_url'],
                                          title: functions
                                              .newsList[randomNumber]['title'],
                                          date: functions.newsList[randomNumber]
                                              ['pubDate'],
                                          author:
                                              functions.newsList[randomNumber]
                                                  ['creator'][0],
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
                                                  functions.newsList.clear();
                                                  setState(() {});
                                                  Future.delayed(
                                                      const Duration(
                                                        seconds: 1,
                                                      ),
                                                      (() => getNewsByCategories(
                                                          tabList[
                                                              selectedIndex])));
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
                                      functions.newsList.length,
                                      (index) => GestureDetector(
                                          onTap: () async {
                                            bool pressed = await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: ((context) {
                                                  return NewsScreen(
                                                    pressed: pressed2,
                                                      news: functions
                                                          .newsList[index],
                                                      image: functions
                                                              .newsList[index]
                                                          ['image_url'],
                                                      title: functions
                                                              .newsList[index]
                                                          ['title'],
                                                      link: functions.newsList[index]
                                                          ['link'],
                                                      author: functions
                                                              .newsList[index]
                                                          ['creator'][0],
                                                      date: functions
                                                              .newsList[index]
                                                          ['pubDate'],
                                                      content: functions
                                                              .newsList[index]
                                                          ['content']);
                                                }),
                                              ),
                                            );
                                            if (pressed == true ||
                                                pressed == false) {
                                              pressed2 = pressed;
                                              setState(() {});
                                            }
                                          },
                                          child: functions.newsList.isEmpty
                                              ? Container(
                                                  color: Colors.pink,
                                                  height: 100,
                                                )
                                              : CardWidget(
                                                  icon: pressed2
                                                      ? const Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        )
                                                      : const Icon(
                                                          Icons
                                                              .favorite_outline,
                                                          color: Colors.black,
                                                        ),
                                                  onpress: () {
                                                    toggle2();

                                                    if (pressed2 == true) {
                                                      final snack = SnackBar(
                                                        content: Text(
                                                          'Added To Favourite',
                                                          style: kDateStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            Colors.black,
                                                        elevation: 5,
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(snack);

                                                      functions
                                                          .addfavouriteNews(
                                                              functions
                                                                      .newsList[
                                                                  index]);
                                                    } else {
                                                      final snack = SnackBar(
                                                        content: Text(
                                                          'Removed from Favourite',
                                                          style: kDateStyle
                                                              .copyWith(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        backgroundColor:
                                                            Colors.black,
                                                        elevation: 5,
                                                        duration:
                                                            const Duration(
                                                                seconds: 2),
                                                      );
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(snack);

                                                      functions
                                                          .removefavouriteNews(
                                                              functions
                                                                      .newsList[
                                                                  index]);
                                                    }
                                                  },
                                                  image:
                                                      functions.newsList[index]
                                                          ['image_url'],
                                                  title: functions
                                                      .newsList[index]['title'],
                                                  date:
                                                      functions.newsList[index]
                                                          ['pubDate'],
                                                  time:
                                                      functions.newsList[index]
                                                          ['pubDate'],
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