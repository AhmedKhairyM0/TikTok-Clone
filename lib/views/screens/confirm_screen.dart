import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../controller/upload_video_controller.dart';
import '../../core/routes.dart';
import '../../core/space_config.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key, required this.videoFile}) : super(key: key);

  final File videoFile;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  late VideoPlayerController _videoPlayerController;
  final TextEditingController _voiceController = TextEditingController();
  final TextEditingController _captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      _videoPlayerController = VideoPlayerController.file(widget.videoFile);
    });
    _videoPlayerController.initialize();
    _videoPlayerController.play();
    _videoPlayerController.setVolume(1);
    _videoPlayerController.setLooping(true);
  }

  Future<void>? uploadVideo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const VerticalSpace(value: 30),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              width: MediaQuery.of(context).size.width,
              child: CustomVideoPlayer(videoController: _videoPlayerController),
            ),
            const VerticalSpace(value: 15),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    TextField(
                      controller: _voiceController,
                      decoration: const InputDecoration(
                        label: Text("Title"),
                        prefixIcon: Icon(Icons.music_note_outlined),
                      ),
                    ),
                    const VerticalSpace(value: 10),
                    TextField(
                      controller: _captionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        label: Text("Caption"),
                        prefixIcon: Icon(Icons.closed_caption),
                      ),
                    ),
                    const VerticalSpace(value: 5),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: CustomElevatedButton(
                        text: "Share!",
                        onPressed: () async {
                          // push loading dialog
                          late BuildContext _dialogContext;
                          _videoPlayerController.pause();

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (dialogContext) {
                              _dialogContext = dialogContext;
                              return const SimpleDialog(
                                children: [
                                  Center(
                                    child: CircularProgressIndicator(),
                                  )
                                ],
                              );
                            },
                          );

                          UploadVideoController.instance
                              .uploadVideo(
                            title: _voiceController.text,
                            caption: _captionController.text,
                            videoFile: widget.videoFile,
                          )
                              .then((value) {
                            // pop loading dialog
                            Navigator.pop(_dialogContext);
                            Navigator.pushReplacementNamed(
                                context, RouteGenerator.videosScreen);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _voiceController.dispose();
    _captionController.dispose();

    super.dispose();
  }
}
