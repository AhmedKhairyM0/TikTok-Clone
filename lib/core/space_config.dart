import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({Key? key, required this.value}) : super(key: key);

  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(width: value);
  }
}

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({Key? key, required this.value}) : super(key: key);

  final double value;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: value);
  }
}
