import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/providers/mobile_no_provider.dart';
import 'package:salon_app/screen/authentication/enter_otp.dart';
import 'package:salon_app/widgets/standard_button.dart';
import 'package:salon_app/providers/loggedinprovider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EnterPhoneNum extends ConsumerStatefulWidget {
  const EnterPhoneNum({super.key});

  @override
  ConsumerState<EnterPhoneNum> createState() => _EnterPhoneNumState();
}

class _EnterPhoneNumState extends ConsumerState<EnterPhoneNum> {
  final phoneNumber = TextEditingController();
  var receivedId = '';
  String _selectedCountryCode = 'IN';
  final auth = FirebaseAuth.instance;
  final _cloud = FirebaseFirestore.instance;
  void verifyUserPhoneNumber(String userNumber) {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
          (value) {
            ref.read(loggedInProvider.notifier).state = true;
            print('Logged In Successfully......................');
          },
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('${e.message}'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        gettingOTP = !gettingOTP;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(104, 121, 85, 72),
                        foregroundColor: Colors.white),
                    child: const Text('Okay'),
                  ),
                ],
              );
            });
      },
      codeSent: (String verificationId, int? resendToken) {
        receivedId = verificationId;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (ctx) => EnterOtp(
              verifyOTP: verifyOTPCode,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('Timeout.........................');
      },
    );
  }

  Future<void> verifyOTPCode(String otp) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedId,
      smsCode: otp,
    );
    ref.read(mobileNoProvider.notifier).state =
        _selectedCountryCode + phoneNumber.text;

    try {
      await auth.signInWithCredential(credential).then((value) {
        ref.read(loggedInProvider.notifier).state = true;
      });

      final docSnapshot = await _cloud
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (!docSnapshot.exists) {
        await _cloud
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'name': phoneNumber.text,
          'address': '',
          'email': '',
          'mob-no': _selectedCountryCode + phoneNumber.text,
          'age': ''
        });
      }
      if (context.mounted) {
        Navigator.pop(context);
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Row(
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 30,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Error',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              content: Text(e.message ?? 'Wrong OTP'),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    if (context.mounted) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: ((context) =>
                              EnterOtp(verifyOTP: verifyOTPCode)),
                        ),
                      );
                    }
                  },
                  icon: const Icon(Icons.done_all_outlined),
                  label: const Text('Okay'),
                ),
              ],
            );
          });
    }
  }

  var gettingOTP = false;
  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Image.asset(
              'asset/images/enter_phone_number.png',
              width: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Please Enter your phone number',
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.brown),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
              child: IntlPhoneField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: _selectedCountryCode,
                onCountryChanged: (value) {
                  setState(() {
                    _selectedCountryCode = '+${value.dialCode}';
                  });
                },
                onChanged: (value) {
                  setState(() {
                    _selectedCountryCode = value.countryCode;
                  });
                },
                controller: phoneNumber,
              ),
            ),
            gettingOTP
                ? StandardButton(text: '', onTap: () {})
                : StandardButton(
                    text: "          Get OTP          ",
                    onTap: () {
                      setState(() {
                        gettingOTP = !gettingOTP;
                      });

                      verifyUserPhoneNumber(
                          _selectedCountryCode + phoneNumber.text);
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
