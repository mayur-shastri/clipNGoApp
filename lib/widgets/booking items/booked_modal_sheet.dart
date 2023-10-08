import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookedModalSheet extends StatelessWidget {
  const BookedModalSheet({
    super.key,
    required this.bookingDetails,
    required this.salonDetails,
  });
  final Map<String, dynamic> bookingDetails;
  final Map<String, dynamic> salonDetails;

  void popSheet(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = bookingDetails['date-time'];
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime).toString();
    final formattedTime = DateFormat('HH:mm').format(dateTime).toString();
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Text(
            'Your request has been sent to the salon.',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Booking Details',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Date: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formattedDate,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Time: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                formattedTime,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Salon Name: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                salonDetails['name'].toString(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Text(
                'Services: ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                bookingDetails['services'].length > 1
                    ? '${bookingDetails['services'][0]['name']} + ${bookingDetails['services'].length - 1} more'
                    : bookingDetails['services'][0]['name'],
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              // open in map logic...
            },
            child: const SizedBox(
                width: 150,
                child: Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                      Text(
                        'Open in Map',
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              // cancel logic (remove from firebase collection)...
              final fetchedListsDocReference = FirebaseFirestore.instance
                  .collection('current-bookings')
                  .doc('${salonDetails['id']}');
              showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: const Text('Are you sure?'),
                      content:
                          const Text('Do you want to cancel this request?'),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No')),
                        TextButton(
                            onPressed: () {
                              fetchedListsDocReference.update({
                                '${salonDetails['id']}': [
                                  {
                                    'uid': bookingDetails['uid'],
                                    'status': 'cancelled'
                                  }
                                ]
                              });
                              print('Successfully cancelled');
                              Navigator.of(context).pop();
                              popSheet(context);
                            },
                            child: const Text('Yes')),
                      ],
                    );
                  });
            },
            child: const SizedBox(
                width: double.infinity,
                child: Center(
                    child: Text(
                  'Cancel Request',
                  style: TextStyle(color: Colors.red),
                ))),
          ),
        ],
      ),
    );
  }
}
