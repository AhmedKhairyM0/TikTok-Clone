import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/models/video.dart';

class VideoController extends GetxController {
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

  likeOrDislikeVideo(String id) async {
    var doc = await firestore.collection("videos").doc(id).get();
    var uid = authController.user.uid;
    bool didUserLikeThisVideoBefore =
        (doc.data()?["likes"] as List<String>).contains(uid);
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
  }
}
