import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/screen/ScreenSwitcher.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MainPage()));
}

class MainPage extends StatelessWidget {
  MainPage({super.key});
  final theme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 197, 134, 39),
    ),
    textTheme: GoogleFonts.ralewayTextTheme(),
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const ScreenSwitcher(),
    );
  }
}
