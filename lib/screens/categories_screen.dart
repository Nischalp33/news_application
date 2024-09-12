import 'package:assign_final/screens/news_detail_screen.dart';
import 'package:assign_final/utils/colors.dart';
import 'package:assign_final/utils/global.dart';
import 'package:assign_final/view_model/news_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    //height width defined for responsiveness
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;

    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'CATEGORIES',
          style: GoogleFonts.anton(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * .05, vertical: 2),
        child: Column(
          children: [
            //category selection for news categories
            SizedBox(
              height: height * .06,
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
            const SizedBox(
              height: 20,
            ),
            //news according to category selected
            Expanded(
              child: FutureBuilder(
                  future: NewsViewModel().getCategoryNews(categoryName),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Align(
                          alignment: Alignment.topCenter,
                          child: LinearProgressIndicator(
                            color: secondaryColor,
                          ));
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime date = DateTime.parse(
                                snapshot.data!.articles![index].publishedAt!);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: InkWell(
                                //navigates to the detail screen
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => NewsDetailScreen(
                                          title: snapshot
                                              .data!.articles![index].title
                                              .toString(),
                                          image: snapshot.data!.articles![index]
                                              .urlToImage!,
                                          description: snapshot
                                              .data!.articles![index].content!,
                                          source: snapshot.data!
                                              .articles![index].source!.name
                                              .toString(),
                                          date: dateFormat.format(date),
                                          url: snapshot
                                              .data!.articles![index].url!),
                                    ),
                                  );
                                },
                                //widget for news list
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          height: height * .18,
                                          width: width * .3,
                                          placeholder: (context, url) =>
                                              const Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey,
                                            child: const Center(
                                                child: Text('No image')),
                                          ),
                                        ),
                                        Expanded(
                                            child: Container(
                                          padding: const EdgeInsets.only(
                                              left: 15, right: 5),
                                          height: height * .18,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                style: GoogleFonts.lora(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  Text(
                                                    dateFormat.format(date),
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ))
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
            )
          ],
        ),
      ),
    );
  }
}
