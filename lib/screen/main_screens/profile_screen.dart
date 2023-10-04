import 'package:flutter/material.dart';
import 'package:salon_app/widgets/user%20related/user_data_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/widgets/user%20related/image_picker.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: const ProfieImagePicker(),
        ),
        const UserDataProfile(),
      ],
    );
  }
}
