import 'package:flutter/material.dart';
import 'package:salon_app/widgets/booking%20items/my_switch_list.dart';

class ServicesSelected extends StatefulWidget {
  const ServicesSelected(
      {super.key, required this.salonDetails, required this.servicesSelected});
  final Map<String, dynamic> salonDetails;
  final List<Map> servicesSelected;
  @override
  State<ServicesSelected> createState() => _ServicesSelectedState();
}

class _ServicesSelectedState extends State<ServicesSelected> {
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
                        children: widget.servicesSelected
                            .map((service) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MySwitchList(servicesSelected: service),
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
      icon: const Icon(Icons.add),
      label: const Text(
        'Select services',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,

          // color: Colors.white,
        ),
      ),
      // style: ElevatedButton.styleFrom(
      //   shape: const RoundedRectangleBorder(),
      //   shadowColor: Colors.black,
      //   backgroundColor: Colors.brown.withOpacity(0.4),
      // ),
    );
  }
}
