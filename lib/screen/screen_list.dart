import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/search_bar.dart';
import 'package:salon_app/widgets/search_results_list.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenListState();
}

class _ScreenListState extends State<ScreenList> {
  List <Map<String, dynamic>> _searchResults = [];

  void _onSearchResultsUpdated() {
    setState(() {
      _searchResults = searchResults;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search your nearest salons'),
        ),
        body: Column(
          children: [
            Center(
              child: MySearchBar(
                  isMainPage: false,
                  onSearchResultsUpdated: _onSearchResultsUpdated),
            ),
            Expanded(
              child: SearchResultsList(latestSearchResults: _searchResults),
            ),
          ],
        ));
  }
}
