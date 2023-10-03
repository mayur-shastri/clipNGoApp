import 'package:flutter/material.dart';
import 'package:salon_app/model/Dev.dart';
import 'package:salon_app/widgets/dev_profile.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});
  static const DevData = [
    Dev(
        name: 'Sagnik Majumder',
        post: 'Flutter Developer',
        linkedInLink: 'https://www.linkedin.com/in/sagnik-majumder-92345524b/',
        profilePicture:
            'https://media.licdn.com/dms/image/D5603AQFdAu1QjAqyxw/profile-displayphoto-shrink_800_800/0/1675007030404?e=1697673600&v=beta&t=65cntQlWb-zHIK7JBSs5SNggdW15Y4KxKPMKa9KY1II'),
    Dev(
        name: 'Pratik Sarangi',
        post: 'Flutter Developer',
        linkedInLink: 'https://www.linkedin.com/in/pratik-sarangi-382535249/',
        profilePicture:
            'https://media.licdn.com/dms/image/C4E03AQF1iK9VcPCthQ/profile-displayphoto-shrink_800_800/0/1661104758761?e=1697673600&v=beta&t=eCeNE_ZE8SncRWxdbEPDsvaZyfqXqg-wFLjGbQ2LjCA'),
    Dev(
        name: 'Mayur R. Shastri',
        post: 'Flutter Developer',
        linkedInLink: 'https://www.linkedin.com/in/mayur-shastri-73772925b/',
        profilePicture:
            'https://media.licdn.com/dms/image/D4D03AQEe4rIfsQsQfg/profile-displayphoto-shrink_800_800/0/1692096731977?e=1697673600&v=beta&t=WanC4KQgfbneYrv7E8FfMcZ_RPjg95-u9ad6x6jwyMo'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Team',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
        ),
        backgroundColor: const Color.fromARGB(255, 66, 66, 66),
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 43, 41, 41),
                Color.fromARGB(255, 93, 93, 93)
              ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  'Developers',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'asset/images/arrow-down.gif',
                  scale: 7,
                ),
              ],
            ),
          ),
          for (var dev in DevData) DevProfile(DevData: dev)
        ],
      ),
    );
  }
}
