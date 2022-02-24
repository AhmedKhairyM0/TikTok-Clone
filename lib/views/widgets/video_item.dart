import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/constants.dart';
import '../../core/space_config.dart';
import '../../models/video.dart';
import 'circle_animation.dart';
import 'custom_icon.dart';
import 'custom_video_player.dart';
import 'favorite_icon_animation.dart';

String formatNumber(num value) {
  double numberOfDigits = log10(value);

  if (numberOfDigits < 3) return value.toString();
  if (numberOfDigits <= 5) return (value / 1000).toString() + "K";
  return (value / 1000).toString() + "M";
}

double log10(num value) {
  return log(value) / log(10);
}

class VideoPlayerItem extends StatefulWidget {
  const VideoPlayerItem({Key? key, required this.video}) : super(key: key);

  final Video video;

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController controller;

  bool isShownText = false;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.video.videoUrl)
      ..initialize().then((value) {
        controller.play();
        controller.setVolume(1);
        controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var videoInfo = widget.video;
    return Container(
      width: size.width,
      height: size.height,
      color: kBackgroundColor,
      child: Stack(
        children: [
          CustomVideoPlayer(videoController: controller),
          Positioned(
            bottom: -30,
            child: Container(
              padding: const EdgeInsets.all(5),
              margin: const EdgeInsetsDirectional.only(start: 20, bottom: 20),
              color: Colors.black.withOpacity(0.03),
              width: size.width * 0.5,
              height: size.height * 0.2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    '@' + videoInfo.username,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const VerticalSpace(value: 5),
                  AutoSizeText(videoInfo.title),
                  const VerticalSpace(value: 5),
                  StatefulBuilder(builder: (context, setstate) {

                    var caption = Text(
                          videoInfo.caption,
                          maxLines: isShownText ? 5 : 1,
                          style: TextStyle(
                            overflow: isShownText
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                        );
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        caption,
                        Visibility(
                          visible: caption.maxLines! > 1,
                          child: GestureDetector(
                            onTap: () {
                              setstate(() {
                                isShownText = !isShownText;
                              });
                            },
                            child: Text(isShownText ? "less" : "more",
                                style: const TextStyle(color: kButtonColor)),
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: size.height * 0.4,
            child: SizedBox(
              width: 100,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildProfile(videoInfo.profilePicture, 1.5),
                  const VerticalSpace(value: 10),
                  Container(
                    margin: const EdgeInsets.only(
                      right: 5,
                    ),
                    child: const FavIconAnimation(),
                    width: 50,
                    height: 50,
                  ),
                  Text(
                    formatNumber(videoInfo.likes.length),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const VerticalSpace(value: 10),
                  CustomIcon(
                    icon: Icons.comment,
                    color: Colors.white,
                    text: formatNumber(videoInfo.commentCount),
                  ),
                  const VerticalSpace(value: 10),
                  CustomIcon(
                    icon: Icons.reply,
                    color: Colors.white,
                    text: formatNumber(videoInfo.shareCount),
                  ),
                  const VerticalSpace(value: 10),
                  CircleAnimation(imageUrl: videoInfo.profilePicture),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfile(String imageProfile, double padding) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.all(padding),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        child: Image.network(
          imageProfile,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
