import 'package:flutter/material.dart';
import 'package:salon_app/widgets/booking%20items/my_switch_list.dart';

class ServicesSelected extends StatefulWidget {
  const ServicesSelected(
      {super.key,
      required this.SalonDetails,
      required this.updateServiceSelected,
      required this.servicesSelected});
  final SalonDetails;
  final Function updateServiceSelected;
  final Map<String, bool> servicesSelected;
  @override
  State<ServicesSelected> createState() => _ServicesSelectedState();
}

class _ServicesSelectedState extends State<ServicesSelected> {
  bool showServices = false;

  void _toggleShowServices() {
    setState(() {
      showServices = !showServices;
    });
  }

  void _showServices() async {
    await showDialog(
      context: context,
      builder: ((context) => AlertDialog(
            title: Text('Select services'),
            content: Column(
                children: widget.SalonDetails['services']
                    .map((service) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MySwitchList(
                            service: service,
                            updateServiceSelected: widget.updateServiceSelected,
                            servicesSelected: widget.servicesSelected),
                      );
                    })
                    .toList()
                    .cast<Widget>()),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'))
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: _showServices,
      icon: Icon(Icons.add, color: Colors.white),
      label: Text(
        'Select services',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(),
        shadowColor: Colors.black,
        backgroundColor: Colors.brown.withOpacity(0.4),
      ),
    );
  }
}
