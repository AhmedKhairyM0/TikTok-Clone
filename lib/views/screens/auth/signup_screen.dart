import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/core/constants.dart';
import 'package:tiktok_clone/core/routes.dart';
import 'package:tiktok_clone/core/space_config.dart';
import 'package:tiktok_clone/core/utils.dart';
import 'package:tiktok_clone/views/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/views/widgets/custom_text_field.dart';
import 'package:tiktok_clone/views/widgets/profile_image.dart';

/// Issues
/// Not preview Network image
/// Not preview Font Awesome Icons
///
///
///

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late Image _image;

  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    _image = Image.asset(
      'assets/images/login_background.jpg',
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
    );
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(_image.image, context); //TODO: Understand this line later
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          ColorFiltered(
            colorFilter: ColorFilter.mode(
              Colors.deepPurple.withOpacity(0.5),
              BlendMode.srcATop,
            ),
            child: _image,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(
              children: [
                ProfileImage(
                  imagePath: imagePath,
                  onPressed: () async {
                    var imageFile = await showDialogToPickImage(context);

                    if (imageFile != null) {
                      imageFile = await cropImage(imageFile.path);
                      setState(() {
                        imagePath = imageFile?.path;
                      });
                    } else {
                      Get.snackbar("Discarded image picker", "");
                    }
                  },
                ),
                const VerticalSpace(value: 40),
                CustomTextField(
                  controller: _usernameController,
                  hint: "Username",
                  prefixIcon: Icons.account_circle,
                ),
                const VerticalSpace(value: 12),
                CustomTextField(
                  controller: _emailController,
                  hint: "Email",
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const VerticalSpace(value: 12),
                CustomTextField(
                  controller: _passwordController,
                  hint: "Password",
                  prefixIcon: FontAwesomeIcons.lock,
                ),
                const VerticalSpace(value: 15),
                RoundedTextIconButton(
                  text: "Sign Up",
                  onPressed: () async {
                    await authController.registerUser(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        image: imagePath == null ? null : File(imagePath!));
                  },
                ),
                const VerticalSpace(value: 20),
                Row(
                  children: [
                    buildDivider(),
                    const Text(' or continue with ', style: kTextStyleNormal),
                    buildDivider(),
                  ],
                ),
                const VerticalSpace(value: 20),
                RoundedTextIconButton(
                  text: "Signup with Google",
                  icon: FontAwesomeIcons.google,
                  color: kGmailColor,
                  onPressed: () {},
                ),
                const VerticalSpace(value: 12),
                RoundedTextIconButton(
                  text: "Signup with Facebook",
                  icon: FontAwesomeIcons.facebook,
                  color: kFacebookColor,
                  onPressed: () {},
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: kTextStyleNormal,
                    ),
                    CustomTextButton(
                      text: "Login",
                      onPressed: () {
                        print("Login");
                        Navigator.pushReplacementNamed(
                            context, RouteGenerator.loginScreen);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<ImageSource?> _showImagePickerDialog(BuildContext context) async {
    ImageSource? imageSource;
    await showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text(
            "Select your profile picture",
          ),
          backgroundColor: Colors.white,
          // shape: ,
          children: [
            TextIconButton(
              onPressed: () {
                imageSource = ImageSource.gallery;
                Navigator.pop(context);
              },
              text: "Gallery",
              icon: FontAwesomeIcons.store,
            ),
            TextIconButton(
              onPressed: () {
                imageSource = ImageSource.camera;
                Navigator.pop(context);
              },
              text: "Camera",
              icon: FontAwesomeIcons.camera,
            ),
          ],
        );
      },
    );
    return imageSource;
  }

  Expanded buildDivider() {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 2,
        color: kBorderColor,
      ),
    );
  }
}
