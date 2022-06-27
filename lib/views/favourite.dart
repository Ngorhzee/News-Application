import 'package:flutter/material.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/news_screen.dart';
import 'package:news_app/widget/card.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key, required this.favouriteList, this.pressed})
      : super(key: key);
  final List<Map<String, dynamic>> favouriteList;
  final bool? pressed;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
   late bool? pressed;
  @override
  Widget build(BuildContext context) {
    //print(widget.favouriteList);
    return Scaffold(
      backgroundColor: kBackgroundColor2,
      body: SafeArea(
        
        child: Column(children: [
          Row(children: [
            IconButton(onPressed: (){
              Navigator.pop(context,!widget.pressed!);
            }, icon:const Icon(Icons.arrow_back)),
            Text(
              'Favourites',
              style: kHealineStyle,
            ),
            const Spacer(),
            widget.favouriteList.isEmpty?Text(''):
            IconButton(
              onPressed: () {
                if(widget.favouriteList.isEmpty){

                }else{
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
                            //mainAxisSize:MainAxisSize.min,
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
                                  pressed=false;
                                  Navigator.pop(context);
                                },
                              ),
                              const Spacer(),
                              ElevatedButton(
                                
                                child: Text(
                                  'No',
                                  style:
                                      kDateStyle.copyWith(color: Colors.blue,backgroundColor: kBackgroundColor2),
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
                }
                
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
                child:  widget.favouriteList.isEmpty?
                    Center(child: Text('No News Added',style: kHealineStyle.copyWith(color: Colors.black),)):
                Column(
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
                                       news: widget.favouriteList[index],);
                                  }),
                                ),
                              );
                            },
                            child: CardWidget(
                              onpress:() {
                                widget.favouriteList.removeAt(index);
                                pressed=false;
                                setState(() {
                                  
                                });
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
