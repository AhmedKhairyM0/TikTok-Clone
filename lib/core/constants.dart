import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/controller/auth_controller.dart';

/// Colors
const kBackgroundColor = Colors.black;
const kButtonColor = Color(0xFFEF5350);
const kBorderColor = Colors.grey;
const kGreyColor = Color(0xFFBDBDBD);
const kOffWhiteColor = Colors.white70;
const kWhiteColor = Colors.white;
const kTransparentColor = Colors.transparent;
const kFacebookColor = Color(0xFF3B5998); //const Color(0xFF1976D2)
const kGmailColor = Color(0xFFDD4B39); //const Color(0xFFDD4B39)

/// Text Style
/// normal
/// heading1
/// heading2

const kTextStyleNormal = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: kGreyColor,
);

const kTextStyleButton = TextStyle(
  fontSize: 15,
  fontWeight: FontWeight.w500,
  color: kButtonColor,
);

const kTextStyleHeading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
const kTextStyleHeading1 = TextStyle(
  fontSize: 40,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

// Firebase

var firebaseAuth = FirebaseAuth.instance;
var firebaseStorage = FirebaseStorage.instance;
var firestore = FirebaseFirestore.instance;

// Controllers

var authController = AuthController.instance;
