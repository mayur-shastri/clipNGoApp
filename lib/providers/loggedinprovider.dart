import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';

final loggedInProvider = StateProvider((ref) {
  return (FirebaseAuth.instance.currentUser != null);
});
