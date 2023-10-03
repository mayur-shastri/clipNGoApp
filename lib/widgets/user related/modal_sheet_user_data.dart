import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/providers/mobile_no_provider.dart';

final _cloud = FirebaseFirestore.instance;

class UserDataUpdate extends ConsumerStatefulWidget {
  UserDataUpdate({super.key});

  @override
  ConsumerState<UserDataUpdate> createState() => _UserDataUpdateState();
}

class _UserDataUpdateState extends ConsumerState<UserDataUpdate> {
  final name = TextEditingController();

  final email = TextEditingController();

  final address = TextEditingController();
  final age = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(String email) {
    RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
    return emailRegex.hasMatch(email);
  }

  bool isValidAddress(String address) {
    RegExp addressRegex = RegExp(r'^[a-zA-Z0-9,.\- ]+$');
    return addressRegex.hasMatch(address);
  }

  bool isValidAge(String age) {
    RegExp ageRegex = RegExp(r'^[0-9]+$');
    return ageRegex.hasMatch(age) && int.parse(age) > 0;
  }

  void _uploadNewInformation() async {
    // _formKey.currentState!.validate();
    if ((_formKey.currentState!.validate())) {
      await _cloud
          .collection('users')
          .doc(ref.read(mobileNoProvider.notifier).state)
          .set({
        'name': name.text,
        'email': email.text,
        'address': address.text,
        'age': age.text,
        'mob-no': ref.read(mobileNoProvider.notifier).state
      });
      if (context.mounted) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                content: Text('Details edited successfully'),
                actions: [
                  TextButton.icon(
                    onPressed: () {
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.done),
                    label: Text('OK'),
                  ),
                ],
              );
            });
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,
            right: 10,
            left: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value == null || value.length < 2) {
                    return 'Name should be of length 2 characters or more';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person, color: Colors.brown),
                  labelStyle: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  } else if (!isValidEmail(value)) {
                    return 'Invalid email address';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email, color: Colors.brown),
                  labelStyle: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: address,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an address';
                  } else if (!isValidAddress(value)) {
                    return 'Invalid address';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.location_on, color: Colors.brown),
                  labelStyle: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: age,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  } else if (!isValidAge(value)) {
                    return 'Invalid age';
                  } else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.calendar_today, color: Colors.brown),
                  labelStyle: TextStyle(
                    color: Colors.brown,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Colors.brown,
                      width: 2,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      color: Colors.brown,
                      width: 1,
                    ),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: _uploadNewInformation,
                child: Text(
                  'Save',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.brown),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
