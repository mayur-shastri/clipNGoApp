import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool _feedbackSubmitted = true;
  final _feedbackController = TextEditingController();
  @override
  void initState() {
    _feedbackSubmitted = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: Text(
          'Contact Us',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Customer Care:',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontSize: 25),
                  ),
                ),
              ),
              const Divider(
                thickness: 3,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  const Icon(Icons.mail),
                  Text(
                    'Email',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'bytebuilders.inc@gmail.com',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Feedback:',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(
                thickness: 3,
                color: Colors.black,
              ),
              const SizedBox(
                height: 30,
              ),
              !_feedbackSubmitted
                  ? const SizedBox(
                      height: 50,
                      child: Center(
                        child: Text('Thankyou for submitting feedback!'),
                      ),
                    )
                  : TextField(
                      controller: _feedbackController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        labelText: 'Write Feedback Here',
                        alignLabelWithHint: true,
                        labelStyle: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
              const SizedBox(
                height: 20,
              ),
              if (_feedbackSubmitted)
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  onPressed: () {
                    FirebaseFirestore.instance.collection('feedback').add({
                      'user-id': FirebaseAuth.instance.currentUser!.uid,
                      'feedback': _feedbackController.text,
                    });
                    setState(() {
                      _feedbackSubmitted = !_feedbackSubmitted;
                    });
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Submit',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
