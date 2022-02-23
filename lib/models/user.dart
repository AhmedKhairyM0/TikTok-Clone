import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String username;
  String email;
  String profilePicture;

  // List<UserId> followers;
  // List<UserId> followingByMe;
  // List<videoUrl> videos

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.profilePicture,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'profilePicture': profilePicture
    };
  }

  factory User.fromSnap(DocumentSnapshot snapshot) {
    var data = snapshot.data() as Map<String, dynamic>;
    return User(
      uid: data['uid'],
      username: data['username'],
      email: data['email'],
      profilePicture: data['profilePicture'],
    );
  }
}
