import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController {
  static VideoController instance = Get.find();
  Rx<List<Video>> _videos = Rx([]);

  List<Video> get videos => _videos.value;

  @override
  void onInit() {
    super.onInit();
    _videos.bindStream(
      firestore.collection("videos").snapshots().map(
        (query) {
          List<Video> videos = [];
          for (var element in query.docs) {
            videos.add(Video.fromSnap(element));
          }
          return videos;
        },
      ),
    );
  }

  Future<void> likeOrDislikeVideo(String id) async {
    try {
      late bool didUserLikeThisVideoBefore;
      videos.forEach((video) => didUserLikeThisVideoBefore =
          video.likes.contains(authController.user.uid));
      var uid = authController.user.uid;

      if (didUserLikeThisVideoBefore) {
        // remove uid from likes
        firestore.collection("videos").doc(id).update({
          "likes": FieldValue.arrayRemove([uid])
        });
      } else {
        // add uid to likes
        firestore.collection("videos").doc(id).update({
          "likes": FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
