import 'dart:convert';

import 'package:eduverse/course_details/coursedetails.dart';
import 'package:eduverse/model/coursedetails.dart';
import 'package:eduverse/model/viewcourses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

class enrolled extends StatefulWidget {
  const enrolled({super.key});

  @override
  State<enrolled> createState() => _enrolledState();
}

class _enrolledState extends State<enrolled> {
  bool isloading = true;

  List<Sector2> view = [];
  Future<void> fetchcourses() async {
    String url =
        "https://eduverse-h05r.onrender.com/courses/a3624ce6-e10c-4464-8afd-b88b2c5a2753/";
    var response = await get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    setState(() {
      view.add(Sector2.fromJson(data));
      isloading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcourses();
  }

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 239, 239, 241),
      appBar: AppBar(
        title: Text("Enrolled Courses"),
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:
                          Offset(0, 2), // changes the position of the shadow
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isloading?SpinKitCircle(color: Colors.blue,): Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Image.network(
                        view[0].data[0].url,
                        scale: 8,
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                view[0].data[0].title,
                                style: TextStyle(
                                    fontSize: a * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: b * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Lectures Attended: ",
                                  style: TextStyle(
                                    fontSize: a * 0.04,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("17 ",
                                  style: TextStyle(
                                      fontSize: a * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 134, 134, 134)))
                            ],
                          ),
                          SizedBox(
                            height: b * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Total Lectures: ",
                                  style: TextStyle(
                                    fontSize: a * 0.04,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("81 ",
                                  style: TextStyle(
                                      fontSize: a * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 134, 134, 134)))
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => coursedetails(
                                                "40bd752f-3105-422a-94a7-a1a634fc82d9")));
                                  },
                                  child: Text("Continue Learning>>",
                                      style: TextStyle(
                                          fontSize: a * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 228, 16, 16))))
                            ],
                          )
                        ],
                      )
                    ]),
              ),
              SizedBox(height: b*0.02,),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset:
                          Offset(0, 2), // changes the position of the shadow
                    )
                  ],
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: isloading?SpinKitCircle(color: Colors.blue,): Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Image.network(
                        view[0].data[4].url,
                      scale: 9,
                      )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Python batch 2023 ",
                                style: TextStyle(
                                    fontSize: a * 0.05,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blue),
                              )
                            ],
                          ),
                          SizedBox(
                            height: b * 0.01,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Lectures Attended: ",
                                  style: TextStyle(
                                    fontSize: a * 0.04,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("28 ",
                                  style: TextStyle(
                                      fontSize: a * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 134, 134, 134)))
                            ],
                          ),
                          SizedBox(
                            height: b * 0.04,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Total Lectures: ",
                                  style: TextStyle(
                                    fontSize: a * 0.04,
                                    fontWeight: FontWeight.w600,
                                  )),
                              Text("55 ",
                                  style: TextStyle(
                                      fontSize: a * 0.04,
                                      fontWeight: FontWeight.w600,
                                      color: const Color.fromARGB(
                                          255, 134, 134, 134)))
                            ],
                          ),
                          Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => coursedetails(
                                                "3c873ff0-7267-4d3a-9ece-537fb3da5719")));
                                  },
                                  child: Text("Continue Learning>>",
                                      style: TextStyle(
                                          fontSize: a * 0.045,
                                          fontWeight: FontWeight.w600,
                                          color: Color.fromARGB(
                                              255, 228, 16, 16))))
                            ],
                          )
                        ],
                      )
                    ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
