import 'package:flutter/material.dart';
import 'package:salon_app/widgets/salon_details.dart';

class NearBySalon extends StatefulWidget {
  const NearBySalon({super.key, required this.nearBySalons});
  final List nearBySalons;
  @override
  State<NearBySalon> createState() => _NearBySalonState();
}

class _NearBySalonState extends State<NearBySalon> {
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
              itemCount: widget.nearBySalons.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, idx) {
                return GestureDetector(
                  onTap: () {},
                  child: Card(
                    child: SalonDetails(
                      idx: idx,
                      SalonList: widget.nearBySalons,
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
