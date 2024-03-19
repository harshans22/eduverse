import 'dart:async';

import 'package:eduverse/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () { 
                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => login()));

    });
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Center(
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
              Container(
              color: Colors.white,
              
              child: SvgPicture.asset("images/loginicon.svg",height: 300,),
             ),
           
           Text.rich(
    TextSpan(
        children: [
            TextSpan(
                text: 'Edu',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                ),
            ),
            TextSpan(
                text: 'Verse',
                style: TextStyle(
                    color: Color(0xFF32D18C),
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    height: 0,
                ),
            ),
        ],
    ),
),
SizedBox(height: 100,),
Lottie.asset("images/eduverse.json"),
                     ],
        ),
      )
    );
  }
}