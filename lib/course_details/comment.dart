import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class comment extends StatefulWidget {
  String uuid;
  comment(this.uuid);

  @override
  State<comment> createState() => _commentState();
}

final GlobalKey<FormState> commentkey = GlobalKey<FormState>();
TextEditingController commentController = TextEditingController();

class _commentState extends State<comment> {
  // Future<http.Response> sendMessage(String comment, String query) {
  //   return http.post(
  //     Uri.parse('https://courses-eduverse.onrender.com/courses/detail/$query/'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //     },
  //     body: jsonEncode(<String, String>{
  //       "message": comment,
  //     }),
  //   );
  // }
  Future<http.Response> sendMessage(String comment, String query) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://eduverse-h05r.onrender.com/courses/comment/$query/'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          "message": comment,
        }),
      );

      print("API Response: ${response.statusCode}");

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
        content: Text('Comment posted successfully',style: TextStyle(fontSize: 14,color: Colors.white),),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
                                      Color.fromARGB(255, 249, 106, 104),
      ),
    );
  }

  void unSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error Occured',style: TextStyle(fontSize: 20,color: Colors.white),),
        
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor:
                                      Color.fromARGB(255, 249, 106, 104),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var b = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Comment"),
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                child: Form(
                  key: commentkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: commentController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        maxLines: null,
                        decoration: InputDecoration(
                          hintText: 'Enter Your Comment',
                          hintStyle: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey),
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Comment cannot be empty";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: b * 0.02,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (commentkey.currentState!.validate()) {
                            final response = await sendMessage(
                                commentController.text, widget.uuid);

                            if (response.statusCode == 201) {
                              // Comment posted successfully
                              showSuccessSnackbar();
                               commentController.clear();
                            } else {
                              // Handle other status codes if needed
                              unSuccessSnackbar();
                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            'Post',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
