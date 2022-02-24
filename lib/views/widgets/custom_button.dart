import 'package:flutter/material.dart';

import '../../core/constants.dart';

class RoundedTextIconButton extends StatelessWidget {
  const RoundedTextIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color = kButtonColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Material(
        color: color,
        child: InkWell(
          onTap: onPressed,
          child: ListTile(
            leading: icon == null ? null : Icon(icon, color: kGreyColor),
            title: Center(
                child:
                    Text(text, style: const TextStyle(color: kOffWhiteColor))),
            contentPadding: EdgeInsets.symmetric(
              horizontal: icon == null ? 0 : 40,
            ),
          ),
        ),
      ),
    );
  }
}

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.color = kBackgroundColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: kGreyColor),
      label: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
            style: kTextStyleButton,
          ),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = kButtonColor,
  }) : super(key: key);

  final String text;
  final Color color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            text,
            style: kTextStyleButton,
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
