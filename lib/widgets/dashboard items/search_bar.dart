import 'package:flutter/material.dart';
import 'package:salon_app/screen/screen_list.dart';

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
        readOnly: true,
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => const ScreenList(),
        )),
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
          hintText: 'Enter salon name or services...',
        ),
      ),
    );
  }
}
