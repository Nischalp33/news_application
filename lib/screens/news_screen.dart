import 'package:assign_final/screens/categories_screen.dart';
import 'package:assign_final/screens/news_detail_screen.dart';
import 'package:assign_final/utils/colors.dart';
import 'package:assign_final/utils/global.dart';
import 'package:assign_final/view_model/news_view_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  Widget build(BuildContext context) {
    //height width defined for responsiveness
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        //icon for news categories
        leading: IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const CategoryScreen()));
            },
            icon: const Icon(
              Icons.menu,
              size: 32,
            )),
        title: Text('TOP HEADLINES', style: GoogleFonts.anton()),

        //pop up menue to select news channel
        actions: [
          Text(
            'Channels',
            style: GoogleFonts.anton(
              fontSize: 18,
            ),
          ),
          PopupMenuButton<FilterList>(
              color: const Color.fromARGB(255, 215, 212, 212),
              icon: const Icon(
                size: 32,
                Icons.filter_list,
                color: Colors.black,
              ),
              onSelected: (FilterList item) {
                if (FilterList.bbcNews.name == item.name) {
                  name = 'bbc-news';
                }
                if (FilterList.abcnews.name == item.name) {
                  name = 'abc-news';
                }
                if (FilterList.axios.name == item.name) {
                  name = 'axios';
                }
                setState(() {});
              },
              itemBuilder: (context) => <PopupMenuEntry<FilterList>>[
                    const PopupMenuItem<FilterList>(
                      value: FilterList.bbcNews,
                      child: Text('BBC News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.abcnews,
                      child: Text('ABC News'),
                    ),
                    const PopupMenuItem<FilterList>(
                      value: FilterList.axios,
                      child: Text('Axios'),
                    ),
                  ])
        ],
      ),
      backgroundColor: primaryColor,
      body: ListView(
        children: [
          //top headlines section of selected news channel
          SizedBox(
            height: height * .48,
            child: FutureBuilder(
              future: NewsViewModel().getHeadlines(name),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(
                        color: secondaryColor,
                      ));
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime date = DateTime.parse(
                          snapshot.data!.articles![index].publishedAt!);
                      return Padding(
                        padding: EdgeInsets.only(
                          left: width * .05,
                        ),
                        child: Container(
                          width: width * .88,
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                CachedNetworkImage(
                                  height: height * .26,
                                  imageUrl: snapshot
                                      .data!.articles![index].urlToImage
                                      .toString(),
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    color: Colors.grey,
                                    child:
                                        const Center(child: Text('No image')),
                                  ),
                                ),
                                SizedBox(
                                  width: width * .8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title!,
                                        style: GoogleFonts.lora(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        snapshot
                                            .data!.articles![index].source!.name
                                            .toString(),
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        dateFormat.format(date),
                                        style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      //navigate to the news detail screen
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => NewsDetailScreen(
                                                  title: snapshot.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  image: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .urlToImage!,
                                                  description: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .content!,
                                                  source: snapshot
                                                      .data!
                                                      .articles![index]
                                                      .source!
                                                      .name
                                                      .toString(),
                                                  date: dateFormat.format(date),
                                                  url: snapshot.data!
                                                      .articles![index].url!),
                                            ),
                                          );
                                        },
                                        child: SizedBox(
                                          width: width * .3,
                                          height: height * .04,
                                          child: const Row(
                                            children: [
                                              Text(
                                                'Read More',
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 252, 87, 16)),
                                              ),
                                              Icon(
                                                Icons.arrow_right_alt,
                                                size: 35,
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          //categories options selection
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: 2),
            child: SizedBox(
              height: height * .045,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        categoryName = categories[index];
                        setState(() {});
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: width * .03),
                        child: Container(
                          width: width * .269,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: categoryName == categories[index]
                                    ? primaryColor
                                    : Colors.black),
                            color: categoryName == categories[index]
                                ? secondaryColor
                                : primaryColor,
                          ),
                          child: Center(
                            child: Text(
                              categories[index].toString(),
                              style: GoogleFonts.lora(
                                  fontSize: 14,
                                  color: categoryName == categories[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          SizedBox(
            height: height * .01,
          ),

          //top two news from  the category selected

          FutureBuilder(
              future: NewsViewModel().getCategoryNews(categoryName),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: secondaryColor,
                  ));
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        DateTime date = DateTime.parse(
                            snapshot.data!.articles![index].publishedAt!);
                        return Padding(
                          padding: EdgeInsets.only(
                              left: width * .05, right: width * .05),
                          child: InkWell(
                            //navigates to the detail screen
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NewsDetailScreen(
                                    title: snapshot.data!.articles![index].title
                                        .toString(),
                                    image: snapshot
                                        .data!.articles![index].urlToImage!,
                                    description: snapshot
                                        .data!.articles![index].content!,
                                    source: snapshot
                                        .data!.articles![index].source!.name
                                        .toString(),
                                    date: dateFormat.format(date),
                                    url: snapshot.data!.articles![index].url!,
                                  ),
                                ),
                              );
                            },
                            //news from category
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                        child: SizedBox(
                                      height: height * .14,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            snapshot
                                                .data!.articles![index].title
                                                .toString(),
                                            maxLines: 2,
                                            style: GoogleFonts.lora(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700),
                                          ),
                                          Text(
                                            dateFormat.format(date),
                                            style: GoogleFonts.poppins(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    )),
                                    CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data!.articles![index].urlToImage
                                            .toString(),
                                        fit: BoxFit.cover,
                                        height: height * .12,
                                        width: width * .3,
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator(
                                              color: secondaryColor,
                                            )),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: Colors.grey,
                                              child: const Center(
                                                  child: Text('No image')),
                                            )),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1.5,
                                  color: Colors.black,
                                  indent: 8,
                                  endIndent: 8,
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
              }),
        ],
      ),
    );
  }
}
