import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/carousel_slider.dart';
import 'package:salon_app/widgets/dashboard%20items/dash_upper.dart';
import 'package:salon_app/widgets/dashboard%20items/near_by_salon.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key, required this.nearBySalons});

  final List nearBySalons;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
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
        NearBySalon(nearBySalons: nearBySalons),
      ],
    );
  }
}
