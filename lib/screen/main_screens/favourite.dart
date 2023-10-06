import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/search_bar.dart';
import 'package:salon_app/widgets/user%20related/favourites_item.dart';

List<Map<String, dynamic>> favouriteSalons = [];

class MyFavourites extends StatelessWidget {
  const MyFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //     child: Text(
        //   'Favourites',
        //   style: Theme.of(context)
        //       .textTheme
        //       .headlineLarge!
        //       .copyWith(color: Theme.of(context).colorScheme.primary),
        // )
        const MySearchBar(isMainPage: false, isFavouritesPage: true),
        Expanded(
          child: ListView(
            children: const [
              FavouritesItem(
                imageURL:
                    'https://media.istockphoto.com/id/1423513079/photo/luxury-hairdressing-and-beauty-salon-interior-with-chairs-mirrors-and-spotlights.webp?b=1&s=170667a&w=0&k=20&c=GTjjLjO1c9SdAGLLJHL3n5sEDdP8dpVXXl3ZpysmxeM=',
              ),
              FavouritesItem(
                imageURL:
                    'https://i.pinimg.com/736x/cc/2d/8e/cc2d8ed6ab6b15422ec9defcb65ee0ec.jpg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
