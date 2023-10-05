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
      builder: ((context) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Text(
                    'Select Services',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 21,
                        color: Colors.brown,
                        fontWeight: FontWeight.bold),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  SingleChildScrollView(
                    child: Column(
                        children: widget.SalonDetails['services']
                            .map((service) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MySwitchList(
                                    service: service,
                                    updateServiceSelected:
                                        widget.updateServiceSelected,
                                    servicesSelected: widget.servicesSelected),
                              );
                            })
                            .toList()
                            .cast<Widget>()),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child:
                          const Text('Done', style: TextStyle(fontSize: 16))),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
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
