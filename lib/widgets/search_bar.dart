import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  final _searchBarText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: MediaQuery.of(context).size.width * 0.85,
      child: TextField(
        controller: _searchBarText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(161, 202, 190, 171),
          contentPadding: EdgeInsets.all(8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          prefixIcon: Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic),
            onPressed: () {},
          ),
          hintText: 'Enter salon name or services...',
        ),
      ),
    );
  }
}
