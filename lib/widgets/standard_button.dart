import 'package:flutter/material.dart';

class StandardButton extends StatelessWidget {
  const StandardButton({super.key, required this.text, required this.onTap});

  final String text;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: const ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.black)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
