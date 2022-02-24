import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController instance = Get.find();

  Future<File?> _compressVideo(String videoPath) async {
    var compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );

    return compressedVideo?.file;
  }

  Future<String> _uploadVideoToStorage(File videoFile, String id) async {
    var ref = firebaseStorage.ref("videos/$id");

    var compressedVideo = await _compressVideo(videoFile.path);

    await ref.putFile(compressedVideo ?? videoFile);
    return await ref.getDownloadURL();
  }

  Future<File> _getThumbnail(String videoPath) async =>
      await VideoCompress.getFileThumbnail(videoPath);

  Future<String> _uploadThumbnailToStorage(File videoFile, String id) async {
    var ref = firebaseStorage.ref("thumbnails/$id");

    var thumbnailImage = await _getThumbnail(videoFile.path);

    await ref.putFile(thumbnailImage);
    return await ref.getDownloadURL();
  }

  Future<void> uploadVideo({
    required String title,
    required String caption,
    required File videoFile,
  }) async {
    try {
      // var videos = await firestore.collection("videos").get();
      String uid = firebaseAuth.currentUser!.uid;

      var videoId =
          uid + "#" + DateTime.now().millisecondsSinceEpoch.toString();

      var videoUrl = await _uploadVideoToStorage(videoFile, videoId);
      var thumbnailUrl = await _uploadThumbnailToStorage(videoFile, videoId);

      var userDocument = await firestore.collection("users").doc(uid).get();
      var user = userDocument.data() as Map<String, dynamic>;

      var video = Video(
        videoUrl: videoUrl,
        title: title,
        caption: caption,
        id: videoId,
        uid: uid,
        username: user['username'],
        profilePicture: user['profilePicture'],
        shareCount: 0,
        likes: [],
        commentCount: 0,
        uploadedDate: Timestamp.now(),
        thumbnailUrl: thumbnailUrl,
      );

      await firestore.collection("videos").doc(videoId).set(video.toJson());

      print("successfully uploading video");
    } catch (error) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        "Error on uploading video",
        error.toString().split(']').last,
      );
    }
  }
}
