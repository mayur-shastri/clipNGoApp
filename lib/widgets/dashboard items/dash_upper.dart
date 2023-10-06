import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/search_bar.dart';

class FavSalonMessage extends StatefulWidget {
  const FavSalonMessage({Key? key}) : super(key: key);

  @override
  State<FavSalonMessage> createState() => _FavSalonMessageState();
}

class _FavSalonMessageState extends State<FavSalonMessage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-0.2, 0),
          end: Offset.zero,
        ).animate(_animationController),
        child: Column(
          children: [
            Text(
              'Find your favourite Salon',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.brown,
                    fontSize: 25,
                  ),
            ),
            const SizedBox(
              height: 20,
            ),
            const MySearchBar(
              isMainPage: true,
              isFavouritesPage: false,
            ),
          ],
        ),
      ),
    );
  }
}
