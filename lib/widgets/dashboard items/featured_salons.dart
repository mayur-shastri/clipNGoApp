import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:salon_app/widgets/salon_details.dart';

class FeaturedSalons extends StatelessWidget {
  const FeaturedSalons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Featured Salons',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    color: Colors.brown),
              ),
              Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          FutureBuilder<QuerySnapshot>(
            future: FirebaseFirestore.instance.collection('salons').get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final salons =
                  snapshot.data!.docs.map((doc) => doc.data()).toList();
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: salons.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(2),
                      child: SalonDetails(
                        SalonList: salons,
                        idx: index,
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
