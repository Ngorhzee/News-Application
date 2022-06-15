import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/get_news.dart';
import 'package:news_app/utilities/constants.dart';
import 'package:news_app/views/search_result.dart';

import '../models/shared_pref.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

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
    StoreSearch storeSearch = StoreSearch();
    searchValue = await storeSearch.storeSearch() ?? [];
    return searchValue;
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
                                  Navigator.pop(context);
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
                             searchValue.add(value);
                            StoreSearch storeSearch = StoreSearch();
                            await storeSearch.saveSearch(searchValue);
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
                              searchValue.length,
                              (index) => GestureDetector(
                                onTap: ()async {
                                  GetNews getNews = GetNews();
                              news.addAll(await getNews.getByKeyword(searchValue[index]));

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
                                        searchValue[index],
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
