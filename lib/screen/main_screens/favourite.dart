import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:salon_app/widgets/dashboard%20items/search_bar.dart';
import 'package:salon_app/widgets/user%20related/favourites_item.dart';

class MyFavourites extends StatefulWidget {
  const MyFavourites({super.key});

  @override
  State<MyFavourites> createState() => _MyFavouritesState();
}

class _MyFavouritesState extends State<MyFavourites> {
  bool _isLoading = false;
  List<Map<String, dynamic>> favouriteSalons = [];
  final _cloud = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  void fetchFavouriteSalons({removeSalon}) async {
    favouriteSalons.clear();
    setState(() {
      _isLoading = true;
    });
    final userSnapshot =
        await _cloud.collection('users').doc(_auth.currentUser!.uid).get();
    final favouriteSalonIdsList = userSnapshot.data()!['favourites'];
    if (favouriteSalonIdsList.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (removeSalon != null) {
      favouriteSalonIdsList.remove(removeSalon['id']);
      await _cloud.collection('users').doc(_auth.currentUser!.uid).update({
        'favourites': FieldValue.arrayRemove([removeSalon['id']])
      });
      if (favouriteSalonIdsList.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }
    for (final id in favouriteSalonIdsList) {
      final salonSnapshot =
          await _cloud.collection('email-salons').doc(id).get();
      final salonData = salonSnapshot.data();
      if (salonData != null && !favouriteSalons.contains(salonData)) {
        setState(() {
          favouriteSalons.add(salonData);
          _isLoading = false;
        });
        print(favouriteSalons);
      } else {
        continue;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFavouriteSalons();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const MySearchBar(isMainPage: false, isFavouritesPage: true),
        Expanded(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : favouriteSalons.isEmpty
                  ? const Center(
                      child: Text('No Favourites yet'),
                    )
                  : ListView.builder(
                      itemCount: favouriteSalons.length,
                      itemBuilder: (ctx, index) {
                        return FavouritesItem(
                          salonDetails: favouriteSalons[index],
                          refreshFavouritesPage: fetchFavouriteSalons,
                        );
                      }),
        ),
      ],
    );
  }
}
