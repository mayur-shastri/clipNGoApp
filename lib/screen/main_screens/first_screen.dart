import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/carousel_slider.dart';
import 'package:salon_app/widgets/dashboard%20items/dash_upper.dart';
import 'package:salon_app/widgets/dashboard%20items/near_by_salon.dart';
import 'package:salon_app/widgets/dashboard%20items/featured_salons.dart';
import 'package:salon_app/widgets/dashboard%20items/services_grid.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key, required this.nearBySalons});

  final List nearBySalons;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 15,
        ),
        const FavSalonMessage(),
        const SizedBox(
          height: 20,
        ),
        const MyCarouselSlider(),
        const SizedBox(
          height: 18,
        ),
        const FeaturedSalons(),
        const ServicesGrid(),
        if (nearBySalons.isNotEmpty) NearBySalon(nearBySalons: nearBySalons),
      ],
    );
  }
}
