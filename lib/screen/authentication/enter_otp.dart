import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:salon_app/widgets/timer.dart';

class EnterOtp extends StatelessWidget {
  const EnterOtp({super.key, required this.verifyOTP});

  final Function(String) verifyOTP;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                "asset/images/enter_otp.png",
                width: 400,
              ),
              Text(
                'Please enter the OTP',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.brown),
              ),
              const SizedBox(
                height: 30,
              ),
              OtpTextField(
                numberOfFields: 6,
                borderColor: const Color(0xFF512DA8),
                showFieldAsBox: true,
                onSubmit: (code) {
                  verifyOTP(code);
                },
              ),
              const Time(),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
