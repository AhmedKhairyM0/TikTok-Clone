import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/auth_controller.dart';
import 'controller/upload_video_controller.dart';
import 'controller/video_controller.dart';
import 'core/routes.dart';
import 'core/theme.dart';
import 'views/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  Get.put(AuthController());
  Get.put(UploadVideoController());

  // Making app always in portrait up
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TikTok Clone',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      onGenerateRoute: RouteGenerator.generate,
      initialRoute: RouteGenerator.homeScreen,
    );
  }
}
