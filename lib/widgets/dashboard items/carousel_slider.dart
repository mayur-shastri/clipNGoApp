import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  final _cloud = FirebaseFirestore.instance;
  Map<String, dynamic>? imageLinkRedirectLinkpairs = {};
  void loadImageLinks() async {
    try {
      final Doc = await _cloud.collection('promotions').doc('only').get();

      setState(() {
        imageLinkRedirectLinkpairs = Doc.data();
      });
    } on FirebaseException catch (e) {
      print('Error loading images: ${e.message}');
    }
  }

  @override
  void initState() {
    loadImageLinks();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: MediaQuery.of(context).size.width * 0.88,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(10)),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          aspectRatio: 16 / 9,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
        items: imageLinkRedirectLinkpairs!.entries.map((pair) {
          final image = pair.key;
          final redirect = pair.value;
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: InkWell(
                  onTap: () async {
                    Uri uriLink = Uri.parse(redirect);
                    launchUrl(
                      uriLink,
                      mode: LaunchMode.inAppWebView,
                    );
                  },
                  child: Image(
                    image: NetworkImage(image),
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
