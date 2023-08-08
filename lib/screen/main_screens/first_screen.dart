import 'package:flutter/material.dart';
import 'package:salon_app/widgets/carousel_slider.dart';
import 'package:salon_app/widgets/dash_upper.dart';
import 'package:salon_app/widgets/near_by_salon.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SizedBox(
          height: 15,
        ),
        FavSalonMessage(),
        SizedBox(
          height: 20,
        ),
        MyCarouselSlider(),
        SizedBox(
          height: 18,
        ),
        NearBySalon(),
      ],
    );
  }
}
