import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lookin good?'),
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
                onPressed: () {},
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
