import 'package:flutter/material.dart';

class MySwitchList extends StatefulWidget {
  const MySwitchList({super.key, required this.servicesSelected});

  final Map servicesSelected;
  @override
  State<MySwitchList> createState() => _MySwitchListState();
}

class _MySwitchListState extends State<MySwitchList> {
  @override
  Widget build(BuildContext context) {
    print(widget.servicesSelected);
    return SwitchListTile(
      title: Text(widget.servicesSelected['name']),
      value: widget.servicesSelected['selected']!,
      onChanged: (_) {
        setState(() {
          widget.servicesSelected['selected'] =
              !widget.servicesSelected['selected']!;
        });
      },
    );
  }
}
