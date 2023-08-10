import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:salon_app/providers/loggedinprovider.dart';

class AuthenticationPage extends ConsumerStatefulWidget {
  const AuthenticationPage({super.key});

  @override
  ConsumerState<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends ConsumerState<AuthenticationPage> {
  final phoneNumber = TextEditingController();
  var pressedLogin = false;
  var otpFieldVisibility = false;

  final otpController = TextEditingController();

  var receivedId = '';

  FirebaseAuth auth = FirebaseAuth.instance;

  void verifyUserPhoneNumber(String userNumber) {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
          (value) {
            print('Logged In Successfully......................');
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        receivedId = verificationId;
        setState(() {
          otpFieldVisibility = true;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timeout.........................');
      },
    );
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedId,
      smsCode: otpController.text,
    );
    await auth.signInWithCredential(credential).then((value) {
      ref.read(loggedInProvider.notifier).state = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    var content = pressedLogin
        ? Column(
            children: [
              TextField(
                controller: phoneNumber,
              ),
              ElevatedButton(
                onPressed: () {
                  if (otpFieldVisibility) {
                    verifyOTPCode();
                  } else {
                    verifyUserPhoneNumber(phoneNumber.text);
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: const Text('Continue'),
              ),
              if (otpFieldVisibility)
                TextField(
                  controller: otpController,
                ),
            ],
          )
        : Center(
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
                      'asset/images/man.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Text(
                    'Login and become a stud today',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        pressedLogin = !pressedLogin;
                      });
                    },
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
          );
    return Scaffold(
      appBar: AppBar(
        title: Text('Lookin good?'),
      ),
      body: content,
    );
  }
}
