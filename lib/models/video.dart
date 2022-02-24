import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String videoUrl;
  String title;
  String caption;
  String id;

  String uid;
  String username;
  String profilePicture;

  int shareCount;
  List likes;
  int commentCount; // !! Not understood why not List<String>

  Timestamp uploadedDate;

  String thumbnailUrl;

  Video({
    required this.videoUrl,
    required this.title,
    required this.caption,
    required this.id,
    required this.uid,
    required this.username,
    required this.profilePicture,
    required this.shareCount,
    required this.likes,
    required this.commentCount,
    required this.uploadedDate,
    required this.thumbnailUrl,
  });

  factory Video.fromSnap(DocumentSnapshot snapshot) {
    var video = snapshot.data() as Map<String, dynamic>;

    return Video(
        videoUrl: video['videoUrl'],
        title: video['title'],
        caption: video['caption'],
        uid: video['uid'],
        username: video['username'],
        profilePicture: video['profilePicture'],
        shareCount: video['views'],
        likes: video['likes'],
        commentCount: video['commentCount'],
        uploadedDate: video['uploadedDate'],
        thumbnailUrl: video['thumbnailUrl'],
        id: video['videoId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'videoUrl': videoUrl,
      'title': title,
      'caption': caption,
      'uid': uid,
      'username': username,
      'profilePicture': profilePicture,
      'views': shareCount,
      'likes': likes,
      'commentCount': commentCount,
      'uploadedDate': uploadedDate,
      'thumbnailUrl': thumbnailUrl,
      'videoId': id,
    };
  }
}

/// video
// {
//   "id": aaa1546432131,
//   "videoUrl":"",
//   "title":"",
//   "id":"",
//   "uid":"",
//   "username":"",
//   "views":"",
//   "likes":"",
//   "commentCount":"",
//   "uploadedDate":"",
//   "thumbnailUrl":"",
//   "comments":[],
//   "__user" : {
//     "uid": "asd215a4sd65aslkjas",
//     "profilePicture": "",
//     ...
//   }
// }

/// user
//  {
//   "id":"asd132a454",
//   "username":"example",
//   "email":"example@example.com"
//   "profilePicture": "https://www.placeholder/200x200.com/" 
//  }


//////////////////////////////////////////////////////////////



/// user
// {
//   "id":"asd132a454",
//   "username":"example",
//   "email":"example@example.com"
//   "profilePicture": "https://www.placeholder/200x200.com/",
//   "videos": [
//     {
//       "id":"asd132a454",
//       "videoUrl": "https://www.youtube.com/..",
//       ...
//     },
//     {
//       "id":"asd132a454",
//       "videoUrl": "https://www.youtube.com/..",
//       ...
//     },
//   ]
// }


