import 'package:flutter/material.dart';
import 'package:salon_app/screen/main_screens/bookings.dart';
import 'package:salon_app/screen/main_screens/favourite.dart';
import 'package:salon_app/screen/main_screens/first_screen.dart';
import 'package:salon_app/screen/main_screens/profile_screen.dart';
import 'package:salon_app/widgets/bottom_navigation_bar.dart';
import 'package:salon_app/widgets/drawer.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Position position;
  late List<Placemark> placemarks;
  String cityName = "Get Current Location";
  int _currentIndex = 0;

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

  void _getLocation() async {
    print('Get location called');
    var permissionStatus = await Permission.locationWhenInUse.request();

    if (permissionStatus.isGranted) {
      // Permission granted, continue with getting the location
      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      _getCityName();
    } else {
      print('Location permission denied.');
      //implement the exception when location is denied
      openAppSettings();
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
          ? FirstScreen()
          : (_currentIndex == 1
              ? MyFavourites()
              : (_currentIndex == 2 ? ProfileScreen() : MyBookings())),
    );
  }
}
