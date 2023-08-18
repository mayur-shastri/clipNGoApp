import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:salon_app/widgets/user%20image%20picker/take_image_button.dart';
import 'dart:io';

class ProfieImagePicker extends StatefulWidget {
  const ProfieImagePicker({super.key});

  @override
  State<ProfieImagePicker> createState() => _ProfieImagePickerState();
}

class _ProfieImagePickerState extends State<ProfieImagePicker> {
  late ImagePicker picker;
  XFile? _userImage;

  @override
  void initState() {
    super.initState();
    picker = ImagePicker();
  }

  void showModalSheet() {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.19,
              width: double.infinity,
              child: Row(
                children: [
                  TakeImageButton(
                    source: 'camera',
                    takeImage: pickImage,
                  ),
                  TakeImageButton(
                    source: 'gallery',
                    takeImage: pickImage,
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> pickImage(ImageSource source) async {
    Navigator.pop(context);
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _userImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = _userImage != null
        ? FileImage(File(_userImage!.path))
        : const AssetImage('asset/images/profile_image_add.png');
    return Center(
      child: Card(
        shape: const CircleBorder(),
        elevation: 20,
        child: InkWell(
          child: CircleAvatar(
            backgroundColor: Colors.brown,
            backgroundImage: content as ImageProvider,
            radius: MediaQuery.of(context).size.height * 0.089,
          ),
          onTap: () {
            showModalSheet();
          },
        ),
      ),
    );
  }
}
