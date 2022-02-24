import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../core/constants.dart';
import '../../../core/routes.dart';
import '../../../core/space_config.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';

/// Issues
/// Not preview Network image
/// Not preview Font Awesome Icons
///
///
///

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late Image _image;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

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
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
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
                  const VerticalSpace(value: 10),
                  Image.asset(
                    'assets/images/tiktok_icon.png',
                    width: 100,
                    height: 100,
                  ),
                  const VerticalSpace(value: 10),
                  Column(
                    children: const [
                      Text('TikTok', style: kTextStyleHeading1),
                      Text(
                        'Enjoy with TikTok World',
                        style: kTextStyleNormal,
                      ),
                    ],
                  ),
                  const VerticalSpace(value: 80),
                  CustomTextField(
                    controller: _emailController,
                    hint: "Email",
                    prefixIcon: Icons.account_circle,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const VerticalSpace(value: 12),
                  CustomTextField(
                    controller: _passwordController,
                    hint: "Password", 
                    prefixIcon: Icons.account_circle,
                  ),
                  const VerticalSpace(value: 15),
                  RoundedTextIconButton(
                    text: "Login",
                    onPressed: ()async {
                      await authController.loginUser(email: _emailController.text, password: _passwordController.text);
                      // show loading dialog
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
                    text: "Login with Google",
                    icon: FontAwesomeIcons.google,
                    color: kGmailColor,
                    onPressed: () {},
                  ),
                  const VerticalSpace(value: 12),
                  RoundedTextIconButton(
                    text: "Login with Facebook",
                    icon: FontAwesomeIcons.facebook,
                    color: kFacebookColor,
                    onPressed: () {},
                  ),

                  // const VerticalSpace(value: 50),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don\'t have an account? ',
                          style: kTextStyleNormal),
                      CustomTextButton(
                        text: "Signup",
                        onPressed: () {

                          Navigator.pushReplacementNamed(context, RouteGenerator.signupScreen);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
