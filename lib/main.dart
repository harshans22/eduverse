import 'package:eduverse/course_details/comment.dart';
import 'package:eduverse/home/home.dart';
import 'package:eduverse/auth/login.dart';
import 'package:eduverse/main/navbar.dart';
import 'package:eduverse/main/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:eduverse/auth/signup.dart';

void main() async{
   
  

  runApp(
    MaterialApp(
      routes: {
        "/": (context) => SplashScreen(),
        "/home":(context) => home(),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}
