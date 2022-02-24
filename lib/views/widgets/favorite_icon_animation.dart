import 'package:flutter/material.dart';

class FavIconAnimation extends StatefulWidget {
  const FavIconAnimation({Key? key}) : super(key: key);

  @override
  _FavIconAnimationState createState() => _FavIconAnimationState();
}

class _FavIconAnimationState extends State<FavIconAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _sizeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _colorAnimation =
        ColorTween(begin: Colors.white, end: Colors.red).animate(_controller);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem(tween: Tween<double>(begin: 40, end: 45), weight: 50),
      TweenSequenceItem(tween: Tween<double>(begin: 45, end: 40), weight: 50),
    ]).animate(_controller);

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return IconButton(
            onPressed: () {
              if (_controller.status == AnimationStatus.completed) {
                _controller.reverse();
              } else if (_controller.status == AnimationStatus.dismissed) {
                _controller.forward();
              }
            },
            icon: const Icon(
              Icons.favorite,
            ),
            color: _colorAnimation.value,
            iconSize: _sizeAnimation.value,
          );
        });
  }
}
