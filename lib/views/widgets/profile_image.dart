import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/constants.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key, this.imagePath, required this.onPressed})
      : super(key: key);

  final String? imagePath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    if (imagePath == null) {
      image = const AssetImage('assets/images/default_profile.png');
    } else {
      image = FileImage(File(imagePath!));
    }
    return InkWell(
      onTap: onPressed,
      child: Center(
        child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: kBorderColor,
              radius: 75,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: image,
                radius: 71,
              ),
            ),
            const Positioned(
              bottom: 0,
              right: 0,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Icon(Icons.camera_alt_outlined),
              ),
            )
          ],
        ),
      ),
    );
  }
}
