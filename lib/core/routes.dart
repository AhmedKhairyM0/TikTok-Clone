import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/auth/signup_screen.dart';
import 'package:tiktok_clone/views/screens/confirm_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';
import 'package:tiktok_clone/views/screens/videos_screen.dart';

class RouteGenerator {
  static const loginScreen = "loginScreen";
  static const signupScreen = "signupScreen";
  static const homeScreen = "homeScreen";
  static const confirmScreen = "confirmScreen";
  static const videosScreen = "videosScreen";


  static Route generate(RouteSettings settings) {
    var args = settings.arguments;

    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signupScreen:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case confirmScreen:
        var pickedVideo = args as File;
        return MaterialPageRoute(builder: (_) => ConfirmScreen(videoFile: pickedVideo,));
      case videosScreen:
        return MaterialPageRoute(builder: (_) => const VideosScreen());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
        builder: (_) =>
            const Scaffold(body: Center(child: Text("Error Screen"))));
  }
}
