import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/get_news.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/search_result.dart';

import '../models/shared_pref.dart';

class SearchView extends StatefulWidget {
   SearchView({Key? key,required this.searchValue}) : super(key: key);
  List<String> searchValue;

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  List<String> searchValue = [];
  @override
  void initState() {
    super.initState();
    saveSearch();
  }

  Future<List<String>> saveSearch()async {
    // StoreSearch storeSearch = StoreSearch();
    //   widget.searchValue = await storeSearch.storeSearch() ?? [];
    setState((){
      widget.searchValue;
    });
    return widget.searchValue;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    List<Map<String, dynamic>> news = [];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                      child: Row(
                    children: [
                      Container(
                        //width: double.infinity,
                        //height: 30,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusedBorder: InputBorder.none,
                            hintText: 'Search',
                            hintStyle: const TextStyle(
                                fontSize: 16, color: Colors.grey),
                            prefixIcon: IconButton(
                                onPressed: () {
                                  Navigator.pop(context,widget.searchValue);
                                },
                                icon: const Icon(Icons.arrow_back)),
                          ),
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) async {
                            value = controller.text;
                           
                            GetNews getNews = GetNews();
                            news.addAll(await getNews.getByKeyword(value));

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => SearchResult(
                                      keyword: news,
                                    )),
                              ),
                            );
                             widget.searchValue.add(value);
                            StoreSearch storeSearch = StoreSearch();
                            await storeSearch.saveSearch(widget.searchValue);
                          },
                        ),
                      )
                    ],
                  )),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text('Recent Searchs',style: kTitleStyle,),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(
                              widget.searchValue.length,
                              (index) => GestureDetector(
                                onTap: ()async {
                                  GetNews getNews = GetNews();
                              news.addAll(await getNews.getByKeyword(widget.searchValue[index]));

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: ((context) => SearchResult(
                                        keyword: news,
                                      )),
                                ),
                              );
                                },
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        widget.searchValue[index],
                                        style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
