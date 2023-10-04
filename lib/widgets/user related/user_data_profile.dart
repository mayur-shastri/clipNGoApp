import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/widgets/user%20related/modal_sheet_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataProfile extends StatefulWidget {
  const UserDataProfile({super.key});
  @override
  State<UserDataProfile> createState() => _UserDataProfileState();
}

final _cloud = FirebaseFirestore.instance;

class _UserDataProfileState extends State<UserDataProfile> {
  void _showModalSheetUserDataUpdate() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return UserDataUpdate();
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _cloud
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Center(
                child: Text('No data'),
              ),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          Map<String, dynamic>? data = snapshot.data!.data();

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Info',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        _showModalSheetUserDataUpdate();
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 20,
                      ),
                      label: const Text('Edit'),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(
                    'Name',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data!['name']),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: Text(
                    'Mobile Number',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['mob-no']),
                ),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['email']),
                ),
                ListTile(
                  leading: const Icon(Icons.location_city),
                  title: Text(
                    'Address',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['address']),
                ),
                ListTile(
                  leading: const Icon(Icons.date_range),
                  title: Text(
                    'Age',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(data['age']),
                ),
              ],
            ),
          );
        });
  }
}
