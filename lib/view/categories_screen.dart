import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/models/categories_news_model.dart';
import 'package:news_app/view/news_detail_screen.dart';
import 'package:news_app/view_model/news_view_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  NewsViewModel newsViewModel = NewsViewModel();
  final format = DateFormat("MMMM dd, YYYY");
  String CategoryName = "General";

  List<String> CategoriesList = [
    "General",
    "Entertainment",
    "Health",
    "Sports",
    "Business",
    "Technology"
  ];

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width * 1;
    final height = MediaQuery.sizeOf(context).height * 1;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: CategoriesList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      CategoryName = CategoriesList[index];
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Container(
                        decoration: BoxDecoration(
                            color: CategoryName == CategoriesList[index]
                                ? Colors.blue
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Center(
                              child: Text(
                            CategoriesList[index].toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          )),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FutureBuilder<CategoriesNewsModel>(
                future: newsViewModel.fatchCategoriesNewsApi(CategoryName),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCircle(
                        size: 50,
                        color: Colors.blue,
                      ),
                    );
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.articles!.length,
                        itemBuilder: (context, index) {
                          DateTime dateTime = DateTime.parse(snapshot
                              .data!.articles![index].publishedAt
                              .toString());
                          return InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => 
                               NewsDetailSceen(
                                newsImage: snapshot.data!.articles![index].urlToImage.toString(), 
                                newsTitle: snapshot.data!.articles![index].title.toString(), 
                                newsDate: snapshot.data!.articles![index].publishedAt.toString(),
                                 author: snapshot.data!.articles![index].author.toString(),
                                  description: snapshot.data!.articles![index].description.toString(),
                                   content: snapshot.data!.articles![index].content.toString(), 
                                   source: snapshot.data!.articles![index].source!.name.toString()) ,));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl: snapshot
                                          .data!.articles![index].urlToImage
                                          .toString(),
                                      fit: BoxFit.cover,
                                      height: height * .18,
                                      width: width * .3,
                                      placeholder: (context, url) => Container(
                                        child: Center(
                                          child: SpinKitCircle(
                                            size: 50,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error_outline,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: height * .18,
                                      padding: EdgeInsets.only(left: 15),
                                      child: Column(
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].title
                                                .toString(),
                                            maxLines: 3,
                                            style: GoogleFonts.poppins(
                                                fontSize: 15,
                                                color: Colors.black54,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Spacer(),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index]
                                                      .source!.name
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 14,
                                                      color: Colors.black54,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
