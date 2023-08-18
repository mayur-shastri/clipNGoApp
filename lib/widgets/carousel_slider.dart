import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyCarouselSlider extends StatefulWidget {
  const MyCarouselSlider({super.key});

  @override
  State<MyCarouselSlider> createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<MyCarouselSlider> {
  final _cloud = FirebaseFirestore.instance;
  List<dynamic> listOfPromotionImages = [];
  void loadImageLinks() async {
    try {
      final Doc =
          await _cloud.collection('images-link-promotion').doc('only').get();

      setState(() {
        listOfPromotionImages = Doc.data()!['links'];
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
        items: listOfPromotionImages.map((image) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Image(image: NetworkImage(image)),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
