import 'package:flutter/material.dart';
import 'package:salon_app/widgets/salon_details.dart';

class NearBySalon extends StatefulWidget {
  const NearBySalon({super.key});

  @override
  State<NearBySalon> createState() => _NearBySalonState();
}

class _NearBySalonState extends State<NearBySalon> {
  final SalonList = [
    {
      'title': 'Lakme Salon - GreenCircle, VELLORE - FOR HIM AND HER',
      'salon-image':
          'https://lh3.googleusercontent.com/p/AF1QipNCOnFzdAQirPOTV630tI2gC6_o4miqn9zYMVE=s1360-w1360-h1020',
      'reviews': 'stars',
      'price': '568'
    },
    {
      'title': 'Essensuals by Toni & Guy.',
      'salon-image':
          'https://lh3.googleusercontent.com/p/AF1QipNGWF4vKmSHdQvjIJjMvZCEIdhheS6NdkWwN0LN=s1360-w1360-h1020',
      'reviews': 'stars',
      'price': '568'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Near by Salon',
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20, color: Colors.brown),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.2,
            child: ListView.builder(
              itemCount: SalonList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: SalonDetails(
                      idx: idx,
                      SalonList: SalonList,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
