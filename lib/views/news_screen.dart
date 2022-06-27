// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:news_app/models/functions.dart';

import 'package:news_app/utilities/constants.dart';

import 'more_news.dart';

class NewsScreen extends StatefulWidget {
  NewsScreen({
    Key? key,
    this.pressed,
    required this.news,
  }) : super(key: key);

  final Map<String, dynamic> news;
  late bool? pressed;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsFunctions functions = NewsFunctions();

  toggle() {
    setState(() {
      widget.pressed = !widget.pressed!;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool onPress = widget.pressed ?? true;
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context, onPress),
                    child: Container(
                      height: 40,
                      width: 40,
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
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      toggle();
                      if (widget.pressed == false) {
                        final snack = SnackBar(
                          content: Text(
                            'Removed from Favourite',
                            style: kDateStyle.copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                          elevation: 5,
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);

                        functions.removefavouriteNews(widget.news);
                      } else {
                        widget.pressed == true;
                        final snack = SnackBar(
                          content: Text(
                            'Added To Favourite',
                            style: kDateStyle.copyWith(color: Colors.white),
                          ),
                          backgroundColor: Colors.black,
                          elevation: 5,
                          duration: const Duration(seconds: 2),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snack);

                        functions.addfavouriteNews(widget.news);
                      }
                      onPress = widget.pressed!;
                    },
                    icon: widget.pressed ?? true
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                          ),
                  )
                ],
              ),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 250,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(widget.news['image_url'] ??
                                    'https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'))),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        widget.news['title'],
                        style: kTitleStyle,
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            widget.news['creator'][0],
                            style: kDateStyle,
                          ),
                          const Spacer(),
                          Text(
                            DateTime.parse(widget.news['pubDate'])
                                    .day
                                    .toString() +
                                '/' +
                                DateTime.parse(widget.news['pubDate'])
                                    .month
                                    .toString() +
                                '/' +
                                DateTime.parse(widget.news['pubDate'])
                                    .year
                                    .toString(),
                            style: kDateStyle,
                          )
                        ],
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(
                        height: 15,
                      ),
                    ),
                    SliverToBoxAdapter(
                        child:
                            Text(widget.news['content'] ?? 'Nothing to show')),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) {
                        return MoreNews(
                            link: widget.news['link'] ?? 'No Availaible Url');
                      }),
                    ),
                  );
                },
                child: Container(
                    height: 80,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10)),
                    child: const Center(
                        child: Text('Show More',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
