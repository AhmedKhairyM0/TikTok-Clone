import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/space_config.dart';

class DialogItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final VoidCallback onPressed;

  const DialogItem({
    Key? key,
    required this.iconData,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: Row(
        children: [
          Icon(iconData),
          const HorizontalSpace(value: 10),
          Text(label),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
