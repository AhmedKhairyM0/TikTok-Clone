import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/core/routes.dart';
import 'package:tiktok_clone/views/widgets/dialog_item.dart';

/// Return file path of the image
Future<String?> pickImage(
    {ImageSource imageSource = ImageSource.camera}) async {
  var pickedImage = await ImagePicker().pickImage(source: imageSource);

  return pickedImage?.path;
}

/// Return file path of the video
Future<String?> pickVideo(
    {ImageSource imageSource = ImageSource.camera}) async {
  var pickedImage = await ImagePicker().pickVideo(source: imageSource);

  return pickedImage?.path;
}

/// Return file path of the image
Future<File?> cropImage(String imagePath) async {
  var imageFile = await ImageCropper.cropImage(
    sourcePath: imagePath,
    aspectRatioPresets: Platform.isAndroid
        ? [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ]
        : [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio5x3,
            CropAspectRatioPreset.ratio5x4,
            CropAspectRatioPreset.ratio7x5,
            CropAspectRatioPreset.ratio16x9
          ],
    androidUiSettings: const AndroidUiSettings(
        toolbarTitle: 'Cropper',
        toolbarColor: Colors.deepOrange,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false),
    iosUiSettings: const IOSUiSettings(title: 'Cropper'),
  );

  return imageFile;
}

/// Dialog for Image Picker Options
Future<File?> showDialogToPickImage(BuildContext context) async {
  File? pickedImage;
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return SimpleDialog(
        title: const Text("Image Picker Options"),
        children: [
          DialogItem(
            iconData: Icons.image_outlined,
            label: "Gallery",
            onPressed: () async {
              var imagePath = await pickImage(imageSource: ImageSource.gallery);
              if (imagePath != null) {
                pickedImage = File(imagePath);
              }
              Navigator.pop(dialogContext);
            },
          ),
          DialogItem(
            iconData: Icons.camera_alt_outlined,
            label: "Camera",
            onPressed: () async {
              var imagePath = await pickImage(imageSource: ImageSource.camera);
              if (imagePath != null) {
                pickedImage = File(imagePath);
              }
              Navigator.pop(dialogContext);
            },
          ),
          DialogItem(
            iconData: Icons.cancel_outlined,
            label: "Cancel",
            onPressed: () => Navigator.pop(dialogContext),
          ),
        ],
      );
    },
  );
  return pickedImage;
}

/// Dialog for Video Picker Options
Future<File?> showDialogToPickVideo(BuildContext context) async {
  File? pickedVideo;
  await showDialog(
    context: context,
    builder: (dialogContext) {
      return SimpleDialog(
        title: const Text("Video Picker Options"),
        children: [
          DialogItem(
            iconData: Icons.image_outlined,
            label: "Gallery",
            onPressed: () async {
              var videoPath = await pickVideo(imageSource: ImageSource.gallery);
              print(videoPath);
              if (videoPath != null) {
                pickedVideo = File(videoPath);
                Navigator.pushReplacementNamed(context, RouteGenerator.confirmScreen,
                    arguments: pickedVideo);
              } else {
                Navigator.pop(dialogContext);
              }
            },
          ),
          DialogItem(
            iconData: Icons.camera_alt_outlined,
            label: "Camera",
            onPressed: () async {
              var videoPath = await pickVideo(imageSource: ImageSource.camera);
              if (videoPath != null) {
                pickedVideo = File(videoPath);
                Navigator.pushReplacementNamed(context, RouteGenerator.confirmScreen,
                    arguments: pickedVideo);
              } else {
                Navigator.pop(dialogContext);
              }
            },
          ),
          DialogItem(
            iconData: Icons.cancel_outlined,
            label: "Cancel",
            onPressed: () => Navigator.pop(dialogContext),
          ),
        ],
      );
    },
  );
  return pickedVideo;
}
