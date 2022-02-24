
import 'package:flutter/material.dart';

import '../../core/space_config.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 40),
        const VerticalSpace(value: 5),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
