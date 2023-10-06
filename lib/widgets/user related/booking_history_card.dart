import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BookingHistoryCard extends StatelessWidget {
  const BookingHistoryCard({super.key, required this.bookingData});

  final Map<String, dynamic> bookingData;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(10),
      surfaceTintColor: Colors.brown,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  bookingData['salon_name'],
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Text(
                  '₹ ${bookingData['price']}',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            Text('Id: ${bookingData['booking_id']}',
                style: Theme.of(context).textTheme.labelSmall!.copyWith(
                      fontSize: 12,
                      color: Colors.grey,
                    )),
            const SizedBox(
              height: 10,
            ),
            // Align(
            //     alignment: Alignment.centerLeft,
            //     child: bookingData['services'].length == 1
            //         ? Text(bookingData['services'][0])
            //         : Text(
            //             '${bookingData['services'][0]},${bookingData['services'][1]}...')),
            // const SizedBox(
            //   height: 10,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('EEEE, d/MMM')
                    .format(bookingData['dateTime'].toDate())),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: bookingData['isSuccess']
                        ? Colors.lightGreen
                        : Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    bookingData['isSuccess'] ? 'Success' : 'Failed',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
