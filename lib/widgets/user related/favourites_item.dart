import 'package:flutter/material.dart';

class FavouritesItem extends StatelessWidget {
  const FavouritesItem({super.key, required this.imageURL});
  final String imageURL;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: 400,
            child: Stack(
              alignment: Alignment.topCenter,
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageURL),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: CircleAvatar(
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loreal Paris',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const Text('5 stars'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
