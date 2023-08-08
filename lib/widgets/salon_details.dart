import 'package:flutter/material.dart';

class SalonDetails extends StatelessWidget {
  SalonDetails({super.key, required this.idx, required this.SalonList});
  final idx;
  final SalonList;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Stack(
        children: [
          Image.network(
            SalonList[idx]['salon-image'],
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
                    SalonList[idx]['title'],
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
