import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/video_controller.dart';
import '../widgets/video_item.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  final PageController _pageController = PageController();

  final VideoController _videoController = Get.put(VideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: _videoController.videos.length,
            itemBuilder: (context, index) {
              return VideoPlayerItem(video: _videoController.videos[index]);
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
