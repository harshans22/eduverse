import 'dart:convert';

import 'package:eduverse/auth/login.dart';
import 'package:eduverse/main/navbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final GlobalKey<FormState> _signkey = GlobalKey<FormState>();

String? _validpassword(value) {
  if (value.isEmpty) {
    return "Please enter password";
  }
  if (!(value.length < 16 && value.length > 6)) {
    return "Password should be between 6-16 words";
  }
}

TextEditingController nameController = TextEditingController();
TextEditingController passController = TextEditingController();
TextEditingController emailController = TextEditingController();

class signup extends StatefulWidget {
  signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

// void _submitform() {
//   if (_signkey.currentState!.validate()) {
//     ScaffoldMessenger.of(_signkey.currentContext!).showSnackBar(
//          SnackBar(content: Text("Form submit successfully")));
//   }
// }

class _signupState extends State<signup> {
  Map<String, List<String>> errorMap = {};

  Future<http.Response> sign(
      String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('https://eduversetryagain.onrender.com/api/register/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "username": username,
          "email": email,
          "password": password
        }),
      );

      print("API Response: ${response.statusCode}");
      print("Response Body: ${response.body}");

      return response;
    } catch (error) {
      print("Error posting comment: $error");
      throw error; // Rethrow the error to handle it in the UI or log it as needed
    }
  }

// function to show snack bar when comment get posted
  void showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Registered Successfully',
          style: TextStyle(
              fontSize: 14, color: const Color.fromARGB(255, 0, 0, 0)),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
    );
  }

  void unSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Already Registered',
          style: TextStyle(
              fontSize: 14, color: const Color.fromARGB(255, 37, 36, 36)),
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.fromARGB(255, 251, 251, 251),
      ),
    );
  }

  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(229, 252, 251, 251),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(a * 0.02, b * 0.02, a * 0.02, 0),
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _signkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: a * 0.2,
                        height: b * 0.3,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: SvgPicture.asset(
                            "images/loginicon.svg",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: b * 0.02,
                      ),
                      Text(
                        'Hello',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: b * 0.01,
                      ),
                      Text(
                        'Create your account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                      SizedBox(
                        height: b * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: b * 0.05,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color.fromARGB(255, 188, 187, 187),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: b * 0.05,
                                  width: a * 0.25,
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => login(),
                                            ));
                                      },
                                      child: Text(
                                        "  Login",
                                        style: TextStyle(
                                          fontSize: a * 0.046,
                                          color: Colors.black,
                                        ),
                                      )),
                                ),
                                Container(
                                  height: b * 0.05,
                                  width: a * 0.3,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                      onPressed: () {},
                                      child: Text(
                                        "Signup",
                                        style: TextStyle(
                                            fontSize: a * 0.046,
                                            color: Colors.black),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            a * 0.06, b * 0.02, a * 0.06, 0),
                        child: TextFormField(
                          controller: nameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                                fontSize: a * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(195, 133, 133, 133)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(10.0)),
                            filled: true,
                            fillColor: Color.fromARGB(255, 247, 243, 243),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter username";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            a * 0.06, b * 0.02, a * 0.06, 0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: "Email",
                            labelStyle: TextStyle(
                                fontSize: a * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(195, 133, 133, 133)),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 247, 243, 243),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter username";
                            }
                            bool isEmailValid = RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              caseSensitive: false,
                            ).hasMatch(value);

                            if (!isEmailValid) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            a * 0.06, b * 0.02, a * 0.06, 0),
                        child: TextFormField(
                          controller: passController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                         
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(
                                fontSize: a * 0.04,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(195, 133, 133, 133)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 247, 243, 243),
                          ),
                          validator: _validpassword,
                        ),
                      ),
                      SizedBox(
                        height: b * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 249, 106, 104)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                if (_signkey.currentState!.validate()) {
                                                       setState(() {
    isloading = true;
  });
                                  final response = await sign(
                                      nameController.text,
                                      emailController.text,
                                      passController.text);

                                  if (response.statusCode == 201) {
                                    // registered posted successfully
                                    nameController.clear();
                                    emailController.clear();
                                    passController.clear();
                                    showSuccessSnackbar();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => navbar(),
                                        ));
                                  }
                                  // if(response){

                                  // }
                                  else {
                                    unSuccessSnackbar();
                                    nameController.clear();
                                    emailController.clear();
                                    passController.clear();
                                    // Handle other status codes if needed
                                    // Bad request - handle validation errors
                                    // Map<String, List<String>> errorBody = jsonDecode(response.body);

                                    // // Accessing the values
                                    // List? usernameErrors = errorBody["username"] ;
                                    // List? emailErrors = errorBody["email"];

                                    // // Check and handle the errors
                                    // if (usernameErrors == "A user with that username already exists.") {
                                    //   print("Username errors: $usernameErrors");

                                    // }

                                    // if (emailErrors == null) {
                                    //   print("Email errors: $emailErrors");
                                    // }
                                  }
                                                       setState(() {
    isloading = false;
  });
                                }
                                ;

                                // if (_formkey.currentState!.validate()) {
                                //        Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => navbar(),
                                //   ));
                                //       ScaffoldMessenger.of(_formkey.currentContext!)
                                //           .showSnackBar( SnackBar(
                                //         content: Text(
                                //           "Login successful",
                                //           style: TextStyle(
                                //               backgroundColor:
                                //                   Color.fromARGB(255, 244, 245, 247),
                                //               color: Color.fromARGB(255, 8, 145, 42)),
                                //         ),
                                //       ));
                                //     }
                              },
                              child: isloading?SpinKitCircle(color: Colors.white,):Text(
                                "Sign Up",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                            ),
                          )
                        ],
                      ),
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  a * 0.2, b * 0.005, a * 0.2, 0),
                              child: Text(
                                "or",
                                style: TextStyle(
                                    fontSize: a * 0.05,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(
                                  a * 0.2, b * 0.005, a * 0.2, 0),
                              child: Text(
                                "continue with",
                                style: TextStyle(
                                    fontSize: a * 0.05,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'images/google.png',
                                  height: b * 0.05,
                                  width: a * 0.2,
                                ),
                                Image.asset(
                                  'images/apple.png',
                                  height: b * 0.05,
                                  width: a * 0.2,
                                ),
                                Image.asset(
                                  'images/facebook.png',
                                  height: b * 0.05,
                                  width: a * 0.2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
