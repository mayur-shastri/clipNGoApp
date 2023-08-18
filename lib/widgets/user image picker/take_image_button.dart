import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakeImageButton extends StatelessWidget {
  const TakeImageButton(
      {super.key, required this.source, required this.takeImage});
  final source;
  final Function takeImage;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.height * 0.12,
        child: source == 'camera'
            ? InkWell(
                child: Column(children: [
                  Icon(
                    Icons.camera,
                    color: Colors.brown,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text('Take from Camera')
                ]),
                onTap: () => takeImage(ImageSource.camera),
              )
            : InkWell(
                child: Column(children: [
                  Icon(
                    Icons.browse_gallery_sharp,
                    color: Colors.brown,
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text('Browse gallery')
                ]),
                onTap: () => takeImage(ImageSource.gallery),
              ),
      ),
    );
  }
}
