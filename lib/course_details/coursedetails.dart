import 'package:eduverse/course_details/comment.dart';
import 'package:eduverse/model/coursedetails.dart';
import 'package:eduverse/model/viewcourses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:video_player/video_player.dart';

class coursedetails extends StatefulWidget {
  String courseuuid;
  coursedetails(this.courseuuid);

  @override
  State<coursedetails> createState() => _coursedetailsState();
}

class _coursedetailsState extends State<coursedetails> {
  bool isloading = true;
  final video = "images/videos/flutter.mp4";
  late VideoPlayerController controller; // video player controller
  List<Coursedetails> view = []; //course details

  Future<void> fetchcoursedetails(String query) async {
    String url = "C";
    var response = await get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      setState(() {
        view.add(Coursedetails.fromJson(data));
        isloading = false;
      });
    } else {
      print("Failed to load data: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
    fetchcoursedetails(widget.courseuuid);
    // video player controller
    controller = VideoPlayerController.asset(video)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  Future<void> _refresh() async {
    setState(() {
      isloading = true;
      view = []; // Clear the existing data before fetching new data
    });
    print(view[0].author);
    await fetchcoursedetails(widget.courseuuid);

    // Use Future.delayed to simulate a delay
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ismuted = controller.value.volume == 0;
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 228, 229),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
        title: Text("Course Details"),
      ),
      body: SafeArea(
          child: RefreshIndicator(
        onRefresh: _refresh,
        child: SingleChildScrollView(
          child: isloading
              ? Column(
                  children: [
                    SizedBox(
                      height: b * 0.4,
                    ),
                    SpinKitPouringHourGlassRefined(color: Colors.red),
                  ],
                )
              : Padding(
                  padding: EdgeInsets.all(22),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              controller.value.isPlaying
                                  ? controller.pause()
                                  : controller.play();
                            },
                            child: Row(
                              // video player widget
                              children: [
                                controller.value.isInitialized
                                    ? Container(
                                        height: b * 0.3,
                                        width: a * 0.87,
                                        alignment: Alignment.center,
                                        child: VideoPlayer(controller),
                                      )
                                    : Container(
                                        height: 200,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          controller.value.isPlaying
                              ? Container()
                              : Container(
                                  child: controller.value.isInitialized
                                      ? IconButton(
                                          onPressed: () {
                                            controller
                                                .setVolume(ismuted ? 1 : 0);
                                          },
                                          icon: Icon(
                                            ismuted
                                                ? Icons.volume_mute
                                                : Icons.volume_up,
                                            color: Colors.white,
                                          ))
                                      : Text(""),
                                ),
                          controller.value.isPlaying
                              ? Container()
                              : Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: VideoProgressIndicator(
                                      padding: EdgeInsets.only(bottom: 10),
                                      controller,
                                      allowScrubbing: true)),
                          Positioned(
                            top: 20,
                            bottom: 20,
                            right: 0,
                            left: 0,
                            child: controller.value.isPlaying
                                ? Container()
                                : Container(
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                      size: 80,
                                    )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: b * 0.02,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 42, 42, 42)
                                  .withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: Offset(
                                  0, 2), // changes the position of the shadow
                            )
                          ],
                          color: Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    view[0].title,
                                    style: TextStyle(decoration: TextDecoration.underline,
                                        fontSize: a * 0.04,
                                        fontWeight: FontWeight.w400),
                                  ),
                        
                                ],
                              ),
                              SizedBox(
                                height: b * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      view[0].courseSections[0].sectionTitle,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: a * 0.045,
                                          fontWeight: FontWeight.w500,
                                          color: const Color.fromARGB(
                                              255, 8, 8, 8)),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: b * 0.02,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    "images/author.svg",
                                    height: b * 0.08,
                                  ),
                                  SizedBox(
                                    width: a * 0.04,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 5, 0, 5),
                                        child: Text(view[0].author,
                                            style: TextStyle(
                                                fontSize: a * 0.05,
                                                fontWeight: FontWeight.w500,
                                                color: Color.fromARGB(
                                                    255, 46, 75, 237))),
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            "images/Star.svg",
                                            height: b * 0.03,
                                          ),
                                          SizedBox(
                                            width: a * 0.02,
                                          ),
                                          Text("4.5",
                                              style: TextStyle(
                                                  fontSize: a * 0.05,
                                                  fontWeight: FontWeight.w400))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: a * 0.02,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      view[0].description,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 20,
                                      style: TextStyle(
                                          fontSize: a * 0.045,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.grey),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: a * 0.02,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    " Students Enrolled :47",
                                    style: TextStyle(
                                        fontSize: a * 0.04,
                                        color:
                                            Color.fromARGB(255, 244, 171, 54)),
                                  ),
                                  Text(
                                    "Price: ₹" + view[0].price,
                                    style: TextStyle(color: Colors.red),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: a * 0.02,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Comments:",
                                            style: TextStyle(
                                                fontSize: a * 0.06,
                                                fontWeight: FontWeight.w500,
                                                decoration:
                                                    TextDecoration.underline),
                                          ),
                                          SizedBox(
                                            height: b * 0.02,
                                          ),
                                          ListView.builder(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount:
                                                view[0].comments.length >= 2
                                                    ? 2
                                                    : view[0].comments.length,
                                            reverse: true,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (context, index) {
                                              final reversedIndex =
                                                  view[0].comments.length -
                                                      index -
                                                      1;
                                              return Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      bottom: 8.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        view[0]
                                                            .comments[
                                                                reversedIndex]
                                                            .message,
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: a * 0.033,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      SizedBox(
                                                        height: b * 0.01,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Text(
                                                            "Posted by: " +
                                                                view[0]
                                                                    .comments[
                                                                        reversedIndex]
                                                                    .user
                                                                    .name,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    a * 0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w800,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        23,
                                                                        22,
                                                                        22)),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                        color: Colors.black,
                                                        thickness: 1,
                                                        indent: 10,
                                                        endIndent: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                comment(widget
                                                                    .courseuuid)));
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(10),
                                                    decoration: BoxDecoration(
                                                      color: Colors.blue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      // boxShadow: [
                                                      //   BoxShadow(
                                                      //     color: Color.fromARGB(
                                                      //             255,
                                                      //             6,
                                                      //             210,
                                                      //             221)
                                                      //         .withOpacity(0.5),
                                                      //     spreadRadius: 2,
                                                      //     blurRadius: 8,
                                                      //     offset: Offset(0,
                                                      //         2), // changes the position of the shadow
                                                      //   )
                                                      // ],
                                                    ),
                                                    child: Text(
                                                      "Post Your Comment",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: a * 0.04),
                                                    ),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
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
      )),
    );
  }
}
