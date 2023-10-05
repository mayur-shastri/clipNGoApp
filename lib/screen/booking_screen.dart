import 'package:flutter/material.dart';
import 'package:salon_app/widgets/booking%20items/services_selected.dart';
import 'package:salon_app/widgets/booking items/time_slot.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key, required this.SalonDetails});
  final SalonDetails;

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  Map<String, bool> servicesSelected = {};
  void updateServiceSelected(String service) {
    servicesSelected[service] = !servicesSelected[service]!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var service in widget.SalonDetails['services']) {
      servicesSelected[service] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            child: Stack(alignment: Alignment.center, children: [
              Image.network(
                widget.SalonDetails['salon-image'],
                fit: BoxFit.cover,
              ),
              Positioned.fill(
                  child: Container(color: Colors.black.withOpacity(0.5))),
              Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    widget.SalonDetails['name'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          ),
          const SizedBox(height: 10),
          Text('Book in 3 easy steps',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                  color: Colors.brown)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  height: 80,
                  width: 150,
                  child: ServicesSelected(
                    SalonDetails: widget.SalonDetails,
                    updateServiceSelected: updateServiceSelected,
                    servicesSelected: servicesSelected,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  height: 80,
                  width: 150,
                  child: TimeSlot(),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
