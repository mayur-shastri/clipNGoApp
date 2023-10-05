import 'package:flutter/material.dart';
import 'package:salon_app/providers/user_location_provider.dart';
import 'package:salon_app/screen/main_screens/bookings.dart';
import 'package:salon_app/screen/main_screens/favourite.dart';
import 'package:salon_app/screen/main_screens/first_screen.dart';
import 'package:salon_app/screen/main_screens/profile_screen.dart';
import 'package:salon_app/widgets/dashboard%20items/bottom_navigation_bar.dart';
import 'package:salon_app/widgets/dashboard%20items/drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _cloud = FirebaseFirestore.instance;

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Position position;
  late List<Placemark> placemarks;
  String cityName = "Location";
  int _currentIndex = 0;
  List nearbySalons = [];
  Future<void> fetchNearBySalons() async {
    // Get the user's location.
    Position? userLocation = ref.read(userLocationProvider.notifier).state;

    // Get all the salons from the Firestore database.
    QuerySnapshot salonsQuerySnapshot =
        await FirebaseFirestore.instance.collection('salons').get();

    // Create a list of all the salons that are nearby to the user location.
    nearbySalons = [];
    if (userLocation != null) {
      for (DocumentSnapshot salonDocumentSnapshot in salonsQuerySnapshot.docs) {
        Map<String, dynamic> salon =
            salonDocumentSnapshot.data() as Map<String, dynamic>;

        // Calculate the distance between the salon and the user.

        double distance = Geolocator.distanceBetween(
            userLocation.latitude,
            userLocation.longitude,
            double.parse(salon['latitude']!),
            double.parse(salon['longitude']!));
        print(
            'latitude: ${userLocation.latitude}, longitude: ${userLocation.longitude}');
        print(
            'latitude: ${double.parse(salon['latitude'])}, longitude: ${double.parse(salon['longitude'])}');

        print('Distance: %%%%%%%%%%%%% ${distance}');
        // Add the salon to the list of nearby salons if the distance is less than a certain threshold.
        if (distance < 100) {
          setState(() {
            nearbySalons.add(salon);
          });
        }
      }
    } else {
      print('Didnt get user location');
    }
  }

  void _onIndexChanged(int newIndex) {
    setState(() {
      _currentIndex = newIndex;
    });
  }

  void openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  void closeDrawer() {
    _scaffoldKey.currentState?.closeDrawer();
  }

  Future<void> _getLocation() async {
    print('Get location called');
    var permissionStatus = await Permission.locationWhenInUse.request();

    if (permissionStatus.isGranted) {
      // Permission granted, continue with getting the location
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      ref.read(userLocationProvider.notifier).state = position;
      fetchNearBySalons();
      _getCityName();
    } else {
      print('Location permission denied.');
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: Text('Permission denied'),
                content:
                    Text('Enable location permission to get nearby salons'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Okay'))
                ],
              );
            });
      }
      //implement the exception when location is denied
      await openAppSettings();
      // await _getLocation();
    }
  }

  void _getCityName() async {
    placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    setState(() {
      cityName = placemarks[0].locality ?? 'Error';
    });
  }

  @override
  void initState() {
    super.initState();

    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: openDrawer,
        ),
        actions: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.pin_drop_rounded),
            label: Text(
              cityName,
            ),
          ),
        ],
        elevation: 1,
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        onIndexChange: _onIndexChanged,
      ),
      drawer: MyDrawer(closeDrawer: closeDrawer),
      body: _currentIndex == 0
          ? FirstScreen(
              nearBySalons: nearbySalons,
            )
          : (_currentIndex == 1
              ? const MyFavourites()
              : (_currentIndex == 2
                  ? const ProfileScreen()
                  : const MyBookings())),
    );
  }
}
