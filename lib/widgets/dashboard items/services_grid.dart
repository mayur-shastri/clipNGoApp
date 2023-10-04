import 'package:flutter/material.dart';

class ServicesGrid extends StatelessWidget {
  const ServicesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text('What are you looking for?',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Colors.brown)),
              Expanded(child: SizedBox()),
            ],
          ),
          SizedBox(
            height: 600,
            width: double.infinity,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/haircut_scissors.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Haircut',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/hair spa.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Hair Spa',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/pedicure.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Pedicure',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/manicures.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Manicure',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/hair color.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Hair Color',
                      )
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Flexible(
                        child: Image.asset(
                          'asset/images/body massage.gif',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Body Massage',
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
