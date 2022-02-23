import 'package:flutter/material.dart';

import 'package:tiktok_clone/core/utils.dart';
import 'package:tiktok_clone/views/widgets/custom_button.dart';

class AddVideoScreen extends StatelessWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomElevatedButton(
        text: "Add Video",
        onPressed: () => showDialogToPickVideo(context),
      ),
    );
  }
}
