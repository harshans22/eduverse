import 'dart:convert';

import 'package:eduverse/main/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class loginwith_OTP extends StatefulWidget {
  const loginwith_OTP({super.key});

  @override
  State<loginwith_OTP> createState() => _loginwith_OTPState();
}

class _loginwith_OTPState extends State<loginwith_OTP> {
  bool isloading = false;
  bool isotp = false;
  //function for calling otp,
  Future<http.Response> sendotp(String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://eduversetryagain.onrender.com/api/login-with-otp/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{"email": email}),
      );

      
      print("API Response: ${response.statusCode}");
      
      print("Response Body: ${response.body}");

      return response;
    } catch (error) {
      print("Error posting comment: $error");
      throw error;
    }
  }

  // for verifying otp
  Future<http.Response> verifyotp(String email, String otp) async {
    try {
      final response = await http.post(
        Uri.parse('https://eduversetryagain.onrender.com/api/validate-otp/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{"email": email, "otp": otp}),
      );

      print("API Response: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response;
    } catch (error) {
      print("Error posting comment: $error");
      throw error; // Rethrow the error to handle it in the UI or log it as needed
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    void showSuccessSnackbar(String query) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '$query',
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      );
    }

    void unSuccessSnackbar(String query) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "$query",
            style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 0, 0)),
          ),
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Verify email"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Container(
                    height: b * 0.35,
                    child: SvgPicture.asset("images/loginwithotp.svg")),
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
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Set default border color
                      ),
                      hintText: "Enter email",
                      labelText: "Email",
                      suffixIcon: isotp
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SpinKitCircle(
                                  color: Colors.blue,
                                  size: 30,
                                ),
                              ],
                            )
                          : TextButton(
                              onPressed: () async {
                                setState(() {
                                  isotp = true;
                                });
                                final response =
                                    await sendotp(emailController.text);
                                if (response.statusCode == 200) {
                                  showSuccessSnackbar(
                                      "OTP was Sent successfully");
                                } else {
                                  unSuccessSnackbar("Invalid Email");
                                  emailController.clear();
                                }
                                setState(() {
                                  isotp = false;
                                });
                              },
                              child: Text("Send OTP"))),
                ),
                SizedBox(
                  height: b * 0.02,
                ),
                TextFormField(
                    controller: otpController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "OTP",
                      labelText: "Enter OTP",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.blue), // Set default border color
                      ),
                    )),
                SizedBox(
                  height: b * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            isloading = true;
                          });
                          final response = await verifyotp(
                              emailController.text, otpController.text);
                          if (response.statusCode == 200) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => navbar(),
                                ));
                            showSuccessSnackbar("login Successfully");
                          } else {
                            unSuccessSnackbar("Invalid OTP");
                            otpController.clear();
                          }
                          setState(() {
                            isloading = false;
                          });
                        },
                        child: isloading
                            ? SpinKitCircle(
                                color: Colors.white,
                              )
                            : Text("Validate OTP")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
