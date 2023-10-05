import 'package:flutter/material.dart';

class SearchResultsCard extends StatelessWidget {
  const SearchResultsCard({
    super.key,
    required this.imageURL,
    required this.name,
  });

  final String imageURL;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          // image widget,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
              radius: 30,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Text(name),
        ],
      ),
    );
  }
}
