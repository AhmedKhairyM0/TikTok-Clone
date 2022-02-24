import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;

  User get user => _user.value!;

  @override
  void onReady() {
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialRoute);
  }

  _setInitialRoute(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  Future<String> _uploadFileToStorage(File file) async {
    var ref = firebaseStorage
        .ref("profile-pictures/${firebaseAuth.currentUser!.uid}");
    await ref.putFile(file);

    return await ref.getDownloadURL();
  }

  Future<void> registerUser({
    required String username,
    required String email,
    required String password,
    required File? image,
  }) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        // create user email-password
        var credential = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        /// upload image
        var downloadUrl = await _uploadFileToStorage(image);

        /// save in firestore
        model.User user = model.User(
          uid: credential.user!.uid,
          username: username,
          email: email,
          profilePicture: downloadUrl,
        );

        await firestore
            .collection("users")
            .doc(credential.user!.uid)
            .set(user.toJson());
        print("Successfully Sign up");
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        Get.snackbar(
          "Error Creating Account",
          "Please enter all data",
        );
      }
    } catch (error) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        "Error Creating Account",
        error.toString().split(']').last,
      );
    }
  }

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      if (password.isNotEmpty && email.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);

        print("Successfully logged in");
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        Get.snackbar(
          "Error Login",
          "Please enter all data",
        );
      }
    } catch (error) {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      Get.snackbar(
        "Error Login",
        error.toString().split(']').last,
      );
    }
  }

  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}

/// register user
/// login user
/// login with google / facebook 
/// 
/// forget password
/// 