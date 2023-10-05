import 'package:flutter/material.dart';

class MySwitchList extends StatefulWidget {
  const MySwitchList(
      {super.key,
      required this.service,
      required this.updateServiceSelected,
      required this.servicesSelected});
  final String service;
  final Function updateServiceSelected;
  final Map<String, bool> servicesSelected;
  @override
  State<MySwitchList> createState() => _MySwitchListState();
}

class _MySwitchListState extends State<MySwitchList> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      title: Text(widget.service),
      value: widget.servicesSelected[widget.service]!,
      onChanged: (_) {
        widget.updateServiceSelected(widget.service);
        setState(() {
          widget.servicesSelected[widget.service] =
              !widget.servicesSelected[widget.service]!;
        });
        widget.updateServiceSelected(widget.service);
      },
    );
  }
}
