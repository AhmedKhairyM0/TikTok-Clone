
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  const CustomVideoPlayer({
    Key? key,
    required VideoPlayerController videoController,
  })  : _videoController = videoController,
        super(key: key);

  final VideoPlayerController _videoController;

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Stack(
        children: [
          VideoPlayer(widget._videoController),
          Center(
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _visible ? 1.0 : 0.0,
              child: const Icon(Icons.play_arrow, size: 60),
            ),
          ),
        ],
      ),
      onTap: () {
        setState(() {
          if (widget._videoController.value.isPlaying) {
            widget._videoController.pause();
            _visible = true;
          } else {
            widget._videoController.play();
            _visible = false;
          }
        });
      },
    );
  }
}
