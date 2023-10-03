import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:salon_app/providers/user_location_provider.dart';

class SalonDetails extends StatefulWidget {
  const SalonDetails({super.key, required this.idx, required this.SalonList});
  final idx;
  final SalonList;

  @override
  State<SalonDetails> createState() => _SalonDetailsState();
}

class _SalonDetailsState extends State<SalonDetails> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Stack(
        children: [
          Image.network(
            widget.SalonList[widget.idx]['salon-image'],
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned.fill(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.center,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    widget.SalonList[widget.idx]['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
