import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/core/space_config.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:tiktok_clone/views/widgets/circle_animation.dart';
import 'package:tiktok_clone/views/widgets/custom_button.dart';
import 'package:tiktok_clone/views/widgets/custom_video_player.dart';
import 'package:video_player/video_player.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, position) {
          return VideoPlayerItem(
            video: Video(
              videoUrl:
                  "https://firebasestorage.googleapis.com/v0/b/tiktok-clone-7c552.appspot.com/o/videos%2FLuOIkAnyejcwV7O1GhZx7b0euSy1%231644484504371?alt=media&token=1117572e-beac-4fcc-902d-4f3cd777e5b0",
              title: "title",
              caption:
                  "caption caption caption caption caption caption caption ",
              id: "id",
              uid: "uid",
              username: "username",
              profilePicture: "https://placeholder.com/100x100",
              views: 0,
              likes: [],
              commentCount: 0,
              uploadedDate: DateTime.now().toIso8601String(),
              thumbnailUrl: "https://placeholder.com/50x50",
            ),
          );
        },
      ),
    );
  }
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
    var info = widget.video;
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
                  AutoSizeText('@' + info.username,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      )),
                  const VerticalSpace(value: 5),
                  AutoSizeText(info.title),
                  const VerticalSpace(value: 5),
                  StatefulBuilder(builder: (context, setstate) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AutoSizeText(
                          info.caption,
                          maxLines: isShownText ? 5 : 1,
                          style: TextStyle(
                            overflow: isShownText
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setstate(() {
                              isShownText = !isShownText;
                            });
                          },
                          child: Text(isShownText ? "less" : "more",
                              style: const TextStyle(color: kButtonColor)),
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
                  buildProfile("https://firebasestorage.googleapis.com/v0/b/tiktok-clone-7c552.appspot.com/o/profile-pictures%2FepJng2jhXAROdqiAlipQHijYgYm2?alt=media&token=0366b9bd-0c2b-4fdd-9540-1b861ad73116", 1.5),
                  const VerticalSpace(value: 10),
                  CustomIcon(
                      icon: Icons.favorite, color: Colors.red, text: "1.2k"),
                  const VerticalSpace(value: 10),
                  CustomIcon(
                      icon: Icons.comment, color: Colors.white, text: "123"),
                  const VerticalSpace(value: 10),
                  CustomIcon(
                      icon: Icons.reply, color: Colors.white, text: "330"),
                  const VerticalSpace(value: 10),
                  CircleAnimation(),
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
