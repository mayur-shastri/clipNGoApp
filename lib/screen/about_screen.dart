import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('About Us')),
      body: Column(
        children: [
          Text(
            'This is an app designed by Mayur Shastri mentored by Syed Mazen Ahmed, this covers all the neccessary informations to carry out another twin tower operation',
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 20),
          )
        ],
      ),
    );
  }
}
