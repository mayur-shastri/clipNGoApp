import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/widgets/user%20related/booking_history_card.dart';

class MyBookings extends ConsumerStatefulWidget {
  const MyBookings({super.key});

  @override
  _MyBookingsState createState() => _MyBookingsState();
}

class _MyBookingsState extends ConsumerState<MyBookings> {
  dynamic bookingData;

  void refresh() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        bookingData = value.data()!['pastBookings'];
        print(bookingData);
      });
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: refresh,
              icon: const Icon(Icons.refresh),
            ),
          ),
          bookingData == null
              ? const SizedBox(
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : bookingData.isEmpty
                  ? const SizedBox(
                      height: 500,
                      child: Center(
                        child: Text('No bookings to show'),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: bookingData.length,
                        itemBuilder: (ctx, index) => BookingHistoryCard(
                          bookingData: bookingData[index],
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
