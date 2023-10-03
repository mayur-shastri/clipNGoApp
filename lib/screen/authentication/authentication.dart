import 'package:flutter/material.dart';
import 'package:salon_app/screen/authentication/enter_phone_num.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  void showLoginSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.8),
        context: context,
        builder: (ctx) {
          return EnterPhoneNum();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome!'),
      ),
      body: Center(
        child: SizedBox(
          height: 500,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                height: 200,
                child: Image.asset(
                  'asset/images/hair_cut_gif_crop.gif',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Login  -  Relax  -  Unwind.',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: showLoginSheet,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  elevation: 2,
                  minimumSize: const Size(200, 40),
                ),
                child: Text(
                  'Get Started',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                        height: 3,
                      ),
                ),
              ),
              const Expanded(child: SizedBox()),
              const Text('With ♡ from bytebuilders'),
            ],
          ),
        ),
      ),
    );
  }
}
