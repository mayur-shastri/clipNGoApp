import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 1),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          'Customer Care:',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 25),
        ),
      ]),
    );
  }
}
