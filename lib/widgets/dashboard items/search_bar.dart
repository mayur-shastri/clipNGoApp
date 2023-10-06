import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/screen/screen_list.dart';

List<Map<String, dynamic>> searchResults = [];



class MySearchBar extends StatefulWidget {
  const MySearchBar(
      {super.key,
      required this.isMainPage,
      required this.isFavouritesPage,
      this.onSearchResultsUpdated});
  final bool isMainPage;
  final bool isFavouritesPage;
  final void Function()? onSearchResultsUpdated;
  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _searchBarText = TextEditingController();
  final _focusNode = FocusNode();
  String? _previousSearchQuery;
  StreamSubscription<QuerySnapshot>? _searchSubscription;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (!widget.isMainPage && !widget.isFavouritesPage) {
      Future(() {
        FocusScope.of(context).requestFocus(_focusNode);
      }); //No delay. keyboard opens immediately.
    }
  }

  void updateList(String searchQuery) async {
    // to make it case insensitive, the document must have
    // a field that has salon name in lowercase, which can then
    // be compared with searchQuery.lowercase() in this function.
    if (!widget.isFavouritesPage) {
      if (searchQuery == _previousSearchQuery) {
        return;
      }
      _previousSearchQuery = searchQuery;
      searchResults.clear();
      if (searchQuery == '') {
        widget.onSearchResultsUpdated!();
        return;
      }
      _searchSubscription?.cancel();
      _searchSubscription = FirebaseFirestore.instance
          .collection('dummy_salons')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: '${searchQuery}z')
          .snapshots()
          .listen((querySnapshot) {
        searchResults.clear();
        for (final doc in querySnapshot.docs) {
          final data = doc.data();
          data['isSalon'] = true;
          searchResults.add(data);
        }
        widget.onSearchResultsUpdated!();
      });
    } else {
      // logic for searching through favourites...
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        focusNode: _focusNode,
        onTap: () {
          if (widget.isMainPage) {
            _focusNode.unfocus();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => const ScreenList(),
            ));
          }
        },
        onChanged: (value) {
          updateList(value);
        },
        controller: _searchBarText,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color.fromARGB(161, 202, 190, 171),
            contentPadding: const EdgeInsets.all(8),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              icon: const Icon(Icons.mic),
              onPressed: () {},
            ),
            hintText: widget.isFavouritesPage
                ? 'Search Favourite Salons...'
                : 'Enter salon name or services...'),
      ),
    );
  }
}
