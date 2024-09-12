// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:assign_final/utils/colors.dart';
import 'package:assign_final/widgets/snackbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final String title, image, description, source, date, url;
  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.image,
    required this.description,
    required this.source,
    required this.date,
    required this.url,
  });

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  //function to share the link to facebook
  void _shareToFacebook() async {
    final url =
        'https://www.facebook.com/sharer/sharer.php?u=${Uri.encodeComponent(widget.url)}';
    log('Attempting to open URL: $url');
    if (await canLaunchUrl(Uri.parse(url))) {
      try {
        await launchUrl(Uri.parse(url));
      } catch (e) {
        log('Error launching URL: $e');

        showSnackBar(context, 'Error: $e');
      }
    } else {
      log('Unable to open: $url');

      showSnackBar(context, 'Unable to open Facebook App');
    }
  }

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
          'News Detail',
          style: GoogleFonts.anton(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
            left: width * .05, right: width * .05, bottom: width * .05),
        //news section of the page
        child: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
          child: Padding(
            padding: EdgeInsets.all(width * .04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    widget.title,
                    style: GoogleFonts.lora(
                        fontSize: 20, fontWeight: FontWeight.w700),
                    maxLines: 2,
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                CachedNetworkImage(
                  height: height * .28,
                  width: double.infinity,
                  imageUrl: widget.image,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey,
                    child: const Center(
                      child: Text('No image'),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .01,
                ),
                Text(
                  '${widget.date} by ${widget.source.toUpperCase()}',
                  style: GoogleFonts.poppins(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: height * .02,
                ),
                //share button for facebook share
                InkWell(
                  onTap: () {
                    _shareToFacebook();
                  },
                  child: Container(
                    height: height * 0.05,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Share to Facebook',
                          style: GoogleFonts.poppins(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                        const Icon(
                          Icons.facebook,
                          size: 30,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .02,
                ),
                Text(
                  widget.description,
                  style: GoogleFonts.lora(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
