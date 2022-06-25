import 'package:flutter/material.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/widget/card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key, required this.favouriteList})
      : super(key: key);
  final List<Map<String, dynamic>> favouriteList;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    //print(widget.favouriteList);
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      body: SafeArea(
        child: Column(children: [
          Row(children: [
            Text(
              'Favourites',
              style: kHealineStyle,
            ),
            IconButton(
              onPressed: () {
            
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Center(
                            child: Icon(Icons.warning,
                                size: 50, color: Colors.red)),
                        backgroundColor: Colors.white,
                        content: Column(children: [
                          Text('Clear Favourites?',
                              style: kHealineStyle.copyWith(fontSize: 20))
                        ]),
                        actions: [
                          Row(
                            mainAxisSize:MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                child: Text(
                                  'Yes',
                                  style: kDateStyle.copyWith(color: Colors.red),
                                ),
                                autofocus: true,
                                onPressed: () {
                                  setState(() {});
                                  widget.favouriteList.clear();
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: Text(
                                  'No',
                                  style:
                                      kDateStyle.copyWith(color: Colors.blue),
                                ),
                                autofocus: true,
                                onPressed: () {
                                  setState(() {});

                                  Navigator.pop(context);
                                },
                              )
                            ],
                          )
                        ],
                      );
                    });
              },
              icon: const Icon(
                Icons.delete,
                color: Color(0xff474C72),
                size: 40,
              ),
            ),
          ]),
          Expanded(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    ...List.generate(
                      widget.favouriteList.length,
                      (index) => 
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) {
                                    return NewsScreen(
                                        image: widget.favouriteList[index]
                                            ['image_url'],
                                        news: widget.favouriteList[index],
                                        title: widget.favouriteList[index]
                                            ['title'],
                                        link: widget.favouriteList[index]
                                            ['link'],
                                        author: widget.favouriteList[index]
                                            ['creator'][0],
                                        content: widget.favouriteList[index]
                                            ['content'],
                                        date: widget.favouriteList[index]
                                            ['pubDate']);
                                  }),
                                ),
                              );
                            },
                            child: CardWidget(
                              onpress:() {
                                widget.favouriteList.removeAt(index);
                              },
                              icon:const Icon (Icons.delete,color: Colors.red,),
                                image: widget.favouriteList[index]['image_url'],
                                title: widget.favouriteList[index]['title'],
                                date: widget.favouriteList[index]['pubDate'],
                                time: widget.favouriteList[index]['pubDate']),
                          ),
                          
                      
                    ),
                  ],
                ),
              )
            ],
          ))
        ]),
      ),
    );
  }
}
