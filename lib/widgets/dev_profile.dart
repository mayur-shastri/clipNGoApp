import 'package:flutter/material.dart';
import 'package:salon_app/model/Dev.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class DevProfile extends StatelessWidget {
  const DevProfile({super.key, required this.DevData});
  final Dev DevData;
  void _launchLinkedInProfile(BuildContext context) async {
    Uri uriLink = Uri.parse(DevData.linkedInLink);
    if (await canLaunchUrl(uriLink)) {
      launchUrl(uriLink, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Error loading!'),
                content: const Text(
                    'We\'re unable to open LinkedIn, please check you have installed the app.'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Okay'))
                ],
              );
            });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(DevData.profilePicture),
          radius: 30,
        ),
        title: Text(
          DevData.name,
          style: GoogleFonts.outfit()
              .copyWith(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Text(DevData.post),
        trailing: IconButton(
          icon: const ImageIcon(
            AssetImage('asset/images/Linkedin-logo-png.png'),
            size: 40,
            color: Color.fromARGB(255, 19, 97, 161),
          ),
          onPressed: () => _launchLinkedInProfile(context),
        ),
      ),
    );
  }
}
