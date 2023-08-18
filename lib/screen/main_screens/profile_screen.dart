import 'package:flutter/material.dart';
import 'package:salon_app/widgets/user_data_profile.dart';
import 'package:salon_app/providers/mobile_no_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/widgets/user%20image%20picker/image_picker.dart';

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
          child: ProfieImagePicker(),
        ),
        UserDataProfile(
          phoneNumber: mobileNumber,
        ),
      ],
    );
  }
}
