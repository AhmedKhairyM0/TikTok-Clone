import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/widgets/custom_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomElevatedButton(
        text: "Sign out",
        onPressed: () {},
      ),
    );
  }
}
