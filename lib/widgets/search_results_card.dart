import 'package:flutter/material.dart';
import 'package:salon_app/screen/booking_screen.dart';

class SearchResultsCard extends StatelessWidget {
  const SearchResultsCard({
    super.key,
    required this.imageURL,
    required this.name,
    required this.isSalon,
  });

  final String imageURL;
  final String name;
  final bool isSalon;
  @override
  Widget build(BuildContext context) {
    const dynamic temp = Map<String, dynamic>; //temporary shit.
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => BookingScreen(
                salonDetails: temp), // replace temp with appropriate shit
          ),
        );
      },
      child: Card(
        child: Row(
          children: [
            // image widget,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(imageURL),
                radius: 30,
              ),
            ),
            const SizedBox(
              width: 30,
            ),
            Column(
              children: [
                Text(name),
                Text(isSalon ? "Salon" : "Service"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
