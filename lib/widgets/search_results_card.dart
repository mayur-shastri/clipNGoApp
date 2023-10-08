import 'package:flutter/material.dart';
import 'package:salon_app/screen/booking_screen.dart';

class SearchResultsCard extends StatelessWidget {
  const SearchResultsCard({
    super.key,
    required this.imageURL,
    required this.name,
    required this.isSalon,
    required this.salonDetails,
  });

  final String imageURL;
  final String name;
  final bool isSalon;
  final Map<String, dynamic> salonDetails;
  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: InkWell(
        onTap: () {
          FocusScope.of(context).unfocus();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => BookingScreen(
                salonDetails: salonDetails,
              ),
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
      ),
    );
  }
}
