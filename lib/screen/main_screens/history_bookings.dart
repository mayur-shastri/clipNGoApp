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
  bool _isLoading = false;
  void refresh() {
    setState(() {
      _isLoading = true;
    });
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        bookingData = value.data()!['pastBookings'];
        _isLoading = false;
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
      child: Stack(
        children: [
          Column(
            children: [
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
                          child: NotificationListener<ScrollNotification>(
                            onNotification: (ScrollNotification scrollInfo) {
                              if (scrollInfo is ScrollEndNotification &&
                                  scrollInfo.metrics.pixels ==
                                      scrollInfo.metrics.maxScrollExtent) {
                                refresh();
                                return true;
                              }
                              return false;
                            },
                            child: ListView.builder(
                              itemCount: bookingData.length,
                              itemBuilder: (ctx, index) => BookingHistoryCard(
                                bookingData: bookingData[index],
                              ),
                            ),
                          ),
                        ),
              const Text(
                'Scroll down to reload bookings',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
          if (_isLoading && bookingData != null)
            const Positioned.fill(
                child: Center(
              child: CircularProgressIndicator(),
            )),
        ],
      ),
    );
  }
}
