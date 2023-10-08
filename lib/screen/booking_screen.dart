import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/widgets/booking%20items/booked_modal_sheet.dart';
import 'package:salon_app/widgets/booking%20items/services_selected.dart';
import 'package:salon_app/widgets/booking items/time_slot.dart';
import 'package:uuid/uuid.dart';

class BookingScreen extends StatefulWidget {
  BookingScreen({
    super.key,
    required this.salonDetails,
    this.resetFavouritesPage,
  });
  final Map<String, dynamic> salonDetails;
  void Function()? resetFavouritesPage;
  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  List<Map> servicesSelected = [];
  DateTime? selectedDateAndTime;
  bool canLeaveScreen = false;
  bool isFavourite = false;
  bool buttonEnabled = true;

  void checkFavouriteStatus() async {
    final userDocSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (userDocSnapshot
        .data()!['favourites']
        .contains(widget.salonDetails['id'])) {
      isFavourite = true;
    }
  }

  void toggleFavourite() {
    setState(() {
      isFavourite = !isFavourite;
      if (isFavourite == true) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'favourites': FieldValue.arrayUnion([widget.salonDetails['id']]),
        });
        if (widget.resetFavouritesPage != null) {
          widget.resetFavouritesPage!();
        }
      } else {
        FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          'favourites': FieldValue.arrayRemove([widget.salonDetails['id']]),
        });
        if (widget.resetFavouritesPage != null) {
          widget.resetFavouritesPage!();
        }
      }
    });
  }

  Future<bool> _onWillPop() async {
    if (canLeaveScreen) {
      return true;
    } else {
      showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Your booking details will be lost'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('Okay Leave'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Stay'),
              ),
            ],
          );
        },
      );
      return true;
    }
  }

  void saveDateTime(DateTime date) {
    selectedDateAndTime = date;
  }

  void _requestBooking() async {
    if (selectedDateAndTime == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Select Date & Time'),
              content:
                  const Text('Please select a date and time for your booking'),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Okay'))
              ],
            );
          });
    } else {
      try {
        final bookingDetails = {
          'salon-id': widget.salonDetails['id'],
          'salon-name': widget.salonDetails['name'],
          'user-id': FirebaseAuth.instance.currentUser!.uid,
          'price': servicesSelected.fold(
              0, (sum, service) => sum + service['price'] as int),
          'services':
              servicesSelected.where((service) => service['selected']).toList(),
          'date-time': selectedDateAndTime,
          'status': 'pending',
          'uid': const Uuid().v4(),
        };
        final fetchedLists = await FirebaseFirestore.instance
            .collection('current-bookings')
            .doc(widget.salonDetails['id'])
            .get();

        if (fetchedLists.exists) {
          final data = fetchedLists.data() as Map<String, dynamic>;
          data[widget.salonDetails['id']].add(bookingDetails);

          await FirebaseFirestore.instance
              .collection('current-bookings')
              .doc(widget.salonDetails['id'])
              .set(data);
        } else {
          await FirebaseFirestore.instance
              .collection('current-bookings')
              .doc(widget.salonDetails['id'])
              .set({
            widget.salonDetails['id']: [bookingDetails]
          });
        }
        setState(() {
          buttonEnabled = false;
          Navigator.of(context).pop();
          showModalBottomSheet(
              enableDrag: false,
              isScrollControlled: true,
              isDismissible: false,
              context: context,
              builder: (ctx) {
                return SingleChildScrollView(
                  child: BookedModalSheet(
                    bookingDetails: bookingDetails,
                    salonDetails: widget.salonDetails,
                  ),
                );
              });
        });
      } on FirebaseException catch (e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Try again later'),
                content: Text(e.message ?? 'Something went wrong'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Okay'))
                ],
              );
            });
      }
    }
  }

  Future<void> makeServicesList() async {
    final servicesSnapshot = await FirebaseFirestore.instance
        .collection('email-salons')
        .doc(widget.salonDetails['id'])
        .collection('services')
        .get();
    final servicesList =
        servicesSnapshot.docs.map((doc) => doc.data()).toList();
    setState(() {
      servicesSelected = servicesList.map((service) {
        return {
          ...service,
          'selected': false,
        };
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    makeServicesList();
    checkFavouriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
        ),
        body: Column(children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                width: double.infinity,
                child: Image.network(
                  widget.salonDetails['image'],
                  fit: BoxFit.cover,
                ),
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
                    widget.salonDetails['name'],
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: CircleAvatar(
                  child: IconButton(
                    onPressed: toggleFavourite,
                    icon: Icon(
                      Icons.favorite,
                      color: !isFavourite ? Colors.grey : Colors.red,
                    ),
                  ),
                ),
              ),
            ]),
          ),
          const SizedBox(height: 10),
          Text(
            'Book in 3 easy steps',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 21, color: Colors.brown),
          ),
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
                    salonDetails: widget.salonDetails,
                    servicesSelected: servicesSelected,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                SizedBox(
                  height: 80,
                  width: 150,
                  child: TimeSlot(
                    saveDateTime: saveDateTime,
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          ),
          const Expanded(child: SizedBox()),
          Row(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 166, 133),
                      shape: const BeveledRectangleBorder(),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                          MediaQuery.of(context).size.height * 0.08),
                    ),
                    child: Text(
                      'Contact Salon',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.brown,
                          fontSize: 18),
                    )),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: buttonEnabled ? _requestBooking : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 147, 61, 30),
                      shape: const BeveledRectangleBorder(),
                      minimumSize: Size(MediaQuery.of(context).size.width * 0.4,
                          MediaQuery.of(context).size.height * 0.08),
                    ),
                    child: Text(
                      'Request Booking',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 18),
                    )),
              )),
            ],
          ),
          const SizedBox(height: 12),
        ]),
      ),
    );
  }
}
