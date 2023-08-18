import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserDataProfile extends StatefulWidget {
  const UserDataProfile({super.key, required this.phoneNumber});
  final String phoneNumber;
  @override
  State<UserDataProfile> createState() => _UserDataProfileState();
}

final _cloud = FirebaseFirestore.instance;

class _UserDataProfileState extends State<UserDataProfile> {
  Map<String, String> retrievedUserData = {
    'name': '',
    'mob-no': '',
    'email': '',
    'age': '',
    'address': ''
  };
  late final userData;
  void fetchUserData(String phoneNumber) async {
    try {
      print(phoneNumber);
      userData = await _cloud.collection('user-data').doc(phoneNumber).get();
      retrievedUserData['name'] = userData.data()!['name'];
      retrievedUserData['mob-no'] = userData.data()!['mob-no'];
      retrievedUserData['email'] = userData.data()!['email'];
      retrievedUserData['age'] = userData.data()!['age'];
      retrievedUserData['address'] = userData.data()!['address'];
      setState(() {});
      print(retrievedUserData);
    } on FirebaseException catch (e) {
      print('Error');
      print(e.message);
    }
  }

  @override
  void initState() {
    super.initState();

    fetchUserData(widget.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
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
                onPressed: () {},
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
            subtitle: Text(retrievedUserData['name'] ?? 'Your Name'),
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
            subtitle: Text(retrievedUserData['mob-no'] ?? '+00 0000000000'),
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
            subtitle: Text(retrievedUserData['email'] ?? 'abc@def.com'),
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
            subtitle:
                Text(retrievedUserData['address'] ?? 'Pune, Australia 799007'),
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
            subtitle: Text(retrievedUserData['age'] ?? '42'),
          ),
        ],
      ),
    );
  }
}
