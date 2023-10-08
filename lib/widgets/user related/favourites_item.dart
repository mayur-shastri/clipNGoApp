import 'package:flutter/material.dart';
import 'package:salon_app/screen/booking_screen.dart';

class FavouritesItem extends StatefulWidget {
  const FavouritesItem({
    super.key,
    required this.salonDetails,
    required this.refreshFavouritesPage,
  });
  final Map<String, dynamic> salonDetails;
  final void Function({Map<String, dynamic> removeSalon}) refreshFavouritesPage;

  @override
  State<FavouritesItem> createState() => _FavouritesItemState();
}

class _FavouritesItemState extends State<FavouritesItem> {
  bool _isFavourite = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) {
            return BookingScreen(
              salonDetails: widget.salonDetails,
              resetFavouritesPage: widget.refreshFavouritesPage,
            );
          },
        ));
      },
      child: Card(
        margin: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              height: 250,
              width: 400,
              child: Stack(
                alignment: Alignment.topCenter,
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.salonDetails['image']),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isFavourite = !_isFavourite;
                            widget.refreshFavouritesPage(
                                removeSalon: widget.salonDetails);
                          });
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: _isFavourite ? Colors.red : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.salonDetails['name'],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const Text('5 stars'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
