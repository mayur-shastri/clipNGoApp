import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryCard extends StatelessWidget {
  const BookingHistoryCard({super.key, required this.bookingData});

  final bookingData; //it's a map that contains data about a particular booking.

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(bookingData['salon_name']),
                Text(bookingData['booking_id']),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                children: [
                  for (final service in bookingData['services']) Text(service),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('dd/MM/yyyy')
                    .format(bookingData['dateTime'].toDate())),
                Text(bookingData['isSuccess']
                    ? 'Completed Successfully'
                    : 'Failed'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
