import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:salon_app/providers/mobile_no_provider.dart';
import 'package:salon_app/screen/authentication/enter_otp.dart';
import 'package:salon_app/widgets/standard_button.dart';
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => EnterOtp(
                      verifyOTP: verifyOTPCode,
                    )));

        // setState(() {
        //   otpFieldVisibility = true;
        // });
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
    await auth.signInWithCredential(credential).then((value) {
      ref.read(loggedInProvider.notifier).state = true;
    });
    ref.read(mobileNoProvider.notifier).state =
        _selectedCountryCode + phoneNumber.text;
    if (context.mounted) {
      Navigator.pop(context);
    }
  }

  String _selectedCountryCode = 'IN';
  @override
  Widget build(BuildContext context) {
    var content = pressedLogin
        ? SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'asset/images/enter_phone_number.png',
                      width: 300,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Please Enter your Mobile Number',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.brown),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                const SizedBox(
                  height: 30,
                ),
                StandardButton(
                  text: "          Get OTP          ",
                  onTap: () {
                    verifyUserPhoneNumber(
                        _selectedCountryCode + phoneNumber.text);
                    print(_selectedCountryCode + phoneNumber.text);
                  },
                ),
              ],
            ),
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
        title: const Text('Lookin good?'),
      ),
      body: content,
    );
  }
}
