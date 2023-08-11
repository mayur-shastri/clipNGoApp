import 'package:flutter/material.dart';
import 'dart:async';

class Time extends StatefulWidget {
  const Time({super.key});

  @override
  State<Time> createState() => _TimeState();
}

class _TimeState extends State<Time> {
  var time = DateTime(2023, 1, 1, 0, 1, 30);
  // year, month, date, hours, minutes, seconds

  late Timer timer;

  @override
  void initState() {
    super.initState();
    startCountdown();
  }

  void restartCountdown() {
    time = DateTime(2023, 1, 1, 0, 1, 30);
    startCountdown();
  }

  void startCountdown() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time.second > 0) {
          time = time.subtract(const Duration(seconds: 1));
        } else if (time.minute > 0) {
          time = time.subtract(const Duration(minutes: 1));
          time = time.add(const Duration(seconds: 59));
        }
        if (time.second == 0 && time.minute == 0) {
          timer.cancel();
        }
      });
    });
  }

  bool isButtonNotDisabled() {
    return time.second == 0 && time.minute == 0;
  }

  @override
  Widget build(BuildContext context) {
    var sec = time.second;
    var min = time.minute;
    return Padding(
      padding: const EdgeInsets.only(
        right: 50.0,
        left: 65.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            time.second < 10 ? "0$min:0$sec" : "0$min:$sec",
            style: const TextStyle(
              color: Colors.blue,
            ),
          ),
          TextButton.icon(
            onPressed:
                time.second == 0 && time.minute == 0 ? restartCountdown : null,
            icon: const Icon(Icons.replay),
            label: Text(
              "Resend OTP",
              style: TextStyle(
                color: isButtonNotDisabled() ? Colors.blue : Colors.grey,
                decoration: TextDecoration.underline,
                decorationColor:
                    isButtonNotDisabled() ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}