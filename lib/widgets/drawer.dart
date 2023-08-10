import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/providers/loggedinprovider.dart';
import 'package:salon_app/screen/about_screen.dart';
import 'package:salon_app/screen/contact_us.dart';

class MyDrawer extends ConsumerStatefulWidget {
  const MyDrawer({super.key});
  @override
  ConsumerState<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends ConsumerState<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('asset/images/comb-scissor.png'),
              ),
              color: Color.fromARGB(255, 117, 81, 26),
            ),
            child: Text(
              'Dashboard',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              // Handle item 1 tap
            },
          ),
          ListTile(
            title: Text('Bookings'),
            onTap: () {
              // Handle item 2 tap
            },
          ),
          ListTile(
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
                return ContactUs();
              }));
            },
          ),
          ListTile(
            title: Text('About'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: ((context) => AboutUs())));
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              ref.read(loggedInProvider.notifier).state = false;
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
    );
  }
}
