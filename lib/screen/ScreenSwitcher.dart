import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:salon_app/screen/authentication.dart';
import 'package:salon_app/screen/dashboard.dart';
import 'package:salon_app/providers/loggedinprovider.dart';

class ScreenSwitcher extends ConsumerStatefulWidget {
  const ScreenSwitcher({super.key});

  @override
  ConsumerState<ScreenSwitcher> createState() => _ScreenSwitcherState();
}

class _ScreenSwitcherState extends ConsumerState<ScreenSwitcher> {
  @override
  Widget build(BuildContext context) {
    final loggedIn = ref.watch(loggedInProvider);
    final content = loggedIn ? const Dashboard() : const AuthenticationPage();
    print(loggedIn);
    return content;
  }
}
