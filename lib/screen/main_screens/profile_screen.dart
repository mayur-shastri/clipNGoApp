import 'package:flutter/material.dart';
import 'package:salon_app/widgets/user_data_profile.dart';
import 'package:salon_app/providers/mobile_no_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String mobileNumber = ref.read(mobileNoProvider);
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 194, 154, 139),
                Color.fromARGB(255, 104, 74, 63)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Card(
              shape: CircleBorder(),
              elevation: 20,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://static.toiimg.com/thumb/msid-62507619,width-1280,resizemode-4/62507619.jpg'),
                radius: MediaQuery.of(context).size.height * 0.089,
              ),
            ),
          ),
        ),
        UserDataProfile(
          phoneNumber: mobileNumber,
        ),
      ],
    );
  }
}
