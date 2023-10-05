import 'package:flutter/material.dart';
import 'package:salon_app/widgets/search_results_card.dart';

class SearchResultsList extends StatefulWidget {
  const SearchResultsList({super.key, required this.latestSearchResults});
  final List<Map<String, dynamic>> latestSearchResults;
  @override
  State<SearchResultsList> createState() => _SearchListSResultstate();
}

class _SearchListSResultstate extends State<SearchResultsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.latestSearchResults.length,
      itemBuilder: (ctx, index) {
        return SearchResultsCard(
          imageURL: widget.latestSearchResults[index]['image'],
          name: widget.latestSearchResults[index]['name'],
        );
      },
    );
  }
}
