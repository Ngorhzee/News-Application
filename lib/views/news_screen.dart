import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utilities/constants.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen(
      {Key? key,
      required this.image,
      required this.title,
      required this.content,
      required this.author,
      required this.date})
      : super(key: key);
  final String? image;
  final String title;
  final String? content;
  final String author;
  final String date;

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late String image;
  @override
  Widget build(BuildContext context) {
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
                    onTap: (){
                      Navigator.pop(context);
                    },
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
                                image: NetworkImage(widget.image ??
                                    'https://thumbs.dreamstime.com/z/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132482953.jpg'))),
                      ),
                    ),
                  const  SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),
                    SliverToBoxAdapter(
                      child: Text(
                        widget.title,
                        style: kTitleStyle,
                      ),
                    ),
                    const  SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            widget.author,
                            style: kDateStyle,
                          ),
                          const Spacer(),
                          Text(
                            DateTime.parse(widget.date).day.toString() +
                                '/' +
                                DateTime.parse(widget.date).month.toString() +
                                '/' +
                                DateTime.parse(widget.date).year.toString() ,
                            style: kDateStyle,
                          )
                        ],
                    
                      ),
                    ),
                    const  SliverToBoxAdapter(
                      child: SizedBox(height: 15,),
                    ),
                    SliverToBoxAdapter(child: Text(widget.content??'Nothing To Show', style: GoogleFonts.nunito(fontSize:16,fontWeight: FontWeight.w400,color: Colors.black87)))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
