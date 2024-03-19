import 'package:carousel_slider/carousel_slider.dart';
import 'package:eduverse/model/courses.dart';
import 'package:eduverse/home/search.dart';
import 'package:eduverse/home/viewallCategories.dart';
import 'package:eduverse/home/viewcourses.dart';
import 'package:eduverse/home/webview.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class home extends StatefulWidget {
  home({super.key});
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  bool isloading = true;
  List<Sector> sectors = [];
  Future<void> fetchData() async {
    String url = "https://eduverse-h05r.onrender.com/courses/";
    var response = await get(Uri.parse(url));
    List<dynamic> data = json.decode(response.body);
    setState(() {
      sectors = data.map((sector) => Sector.fromJson(sector)).toList();
      isloading = false;
    });
  }

  Future<void> _refresh() async {
    setState(() {
      isloading = true;
      sectors = []; // Clear the existing data before fetching new data
    });

    await fetchData();
    print(sectors[0].sectorName);
    // Use Future.delayed to simulate a delay
    await Future.delayed(Duration(seconds: 2));
  }

  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  List images = [
    "images/slider/image1.jpg",
    "images/slider/image2.png",
    "images/slider/image3.png",
    "images/slider/image4.jpg",
    "images/slider/image5.jpg",
    "images/slider/image6.avif",
  ];
  // List images = [
  //   {"id": 1, "image_path": "images/slider/image1.jpg",},
  //   {"id": 2, "image_path": "images/slider/image2.png",},
  //   {"id": 3, "image_path": "images/slider/image3.png",},
  //   {"id": 4, "image_path": "images/slider/image4.png",},
  //   {"id": 5, "image_path": "images/slider/image5.png",},
  //   {"id": 6, "image_path": "images/slider/image6.png",},
  // ];
  final CarouselController carouselController = CarouselController();
  int currentindex = 0;

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(232, 234, 234, 238),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: Column(
                children: [
                  Row(
                    children: [
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
                      SizedBox(width: a * 0.35),
                      //want the same image to get displayed here
                      //  SvgPicture.asset("images/profileicon.svg"),
                    ],
                  ),
                  // SizedBox(
                  //   height: b * 0.005,
                  // ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => search()));
                        },
                        child: Container(
                            height: b * 0.08,
                            width: a * 0.7,
                            child: SvgPicture.asset(
                              "images/search.svg",
                              width: a,
                            )),
                      ),
                      SizedBox(
                        width: a * 0.01,
                      ),
                      SvgPicture.asset(
                        'images/4dotblue.svg',
                        height: b * 0.07,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: b * 0.005,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => web()));
                          },
                          child: Container(
                              height: b * 0.2,
                              width: a * 0.86,
                              child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(1,
                                              -2), // changes the position of the shadow
                                        )
                                      ],
                                    ),
                                    child: SvgPicture.asset(
                                        "images/start the course.svg"),
                                  ))))
                    ],
                  ),
                  SizedBox(
                    child: Container(
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: CarouselSlider(
                                items: images.map((imagePath) {
                                  return Image.asset(
                                    imagePath,
                                    fit: BoxFit
                                        .contain, // You can adjust the BoxFit based on your requirement
                                    width: double.infinity,
                                    height: double.infinity,
                                  );
                                }).toList(),
                                carouselController: carouselController,
                                options: CarouselOptions(
                                  autoPlayInterval: Duration(seconds: 2),
                                  scrollPhysics: const BouncingScrollPhysics(),
                                  autoPlay: true,
                                  aspectRatio: 2,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      currentindex = index;
                                    });
                                  },
                                )),
                          ),
                          Positioned(
                            bottom: 10,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Row(
                  //   children: [
                  //     Text("Categories",
                  //         style: TextStyle(
                  //             fontSize: 18, fontWeight: FontWeight.w500)),
                  //     SizedBox(width: a * 0.4),
                  //     TextButton(
                  //         onPressed: () {
                  //           ;
                  //         },
                  //         child: Text("View all >",
                  //             style: TextStyle(
                  //                 color: Color.fromARGB(255, 6, 33, 167),
                  //                 fontSize: 13,
                  //                 fontWeight: FontWeight.w600))),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       height: b * 0.08,
                  //       width: a * 0.8,
                  //       child: ListView.builder(

                  //         itemCount: sectors.length,
                  //         scrollDirection: Axis.horizontal,
                  //         itemBuilder: (context, index) {
                  //           return Container(
                  //             padding: EdgeInsets.all(10),
                  //             child: ChoiceChip(
                  //               iconTheme: IconThemeData(color: Colors.pink),
                  //               shape: RoundedRectangleBorder(
                  //                   borderRadius: BorderRadius.circular(20)),
                  //               side: BorderSide(color: Colors.grey),
                  //               label:
                  //                   EllipsizedText(cat[sectors[index].sectorName]),
                  //               labelStyle: TextStyle(color: Colors.white),
                  //               onSelected: (bool selected) {
                  //                 setState(() {
                  //                   _value = selected ? index : null;
                  //                 });
                  //               },
                  //               selected: _value == index,
                  //               backgroundColor:_value == index
                  //                     ? Color.fromARGB(255, 211, 42, 42)
                  //                     : Color.fromARGB(232, 12, 12, 13),
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      Text("Featured class",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w500)),
                      SizedBox(width: a * 0.32),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        viewallCategories(sectors)));
                          },
                          child: Text("View all >",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 6, 33, 167),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600)))
                    ],
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                    0, 2), // changes the position of the shadow
                              )
                            ],
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isloading
                                ? SpinKitHourGlass(
                                    color: Color.fromARGB(255, 249, 106, 104))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                          fit: BoxFit.cover,
                                          child: Image.network(
                                            sectors[0].sectorImage,
                                            width: a * 0.6,
                                            height: b * 0.2,
                                          )),
                                      SizedBox(height: b * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: a * 0.23,
                                            child: EllipsizedText(
                                              sectors[0].sectorName,
                                              style: TextStyle(
                                                  fontSize: a * 0.033,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 128, 126, 126)),
                                            ),
                                          ),
                                          Text(
                                            "₹" +
                                                sectors[0]
                                                    .featuredCourses[0]
                                                    .price,
                                            style: TextStyle(
                                                fontSize: a * 0.03,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: b * 0.01),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                              child: SvgPicture.asset(
                                            "images/author.svg",
                                            height: b * 0.05,
                                          )),
                                        
                                          Column(
                                            children: [
                                              Text(
                                                  sectors[0]
                                                      .featuredCourses[0]
                                                      .author,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              Text("4.5 star",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: b * 0.01),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      viewcourses(sectors[0]
                                                          .sectorUuid)));
                                        },
                                        child: Center(
                                            child: FittedBox(
                                                child: SvgPicture.asset(
                                          "images/view courses.svg",
                                          width: a,
                                        ))),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: a * 0.04,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: Offset(
                                    0, 2), // changes the position of the shadow
                              )
                            ],
                            color: Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isloading
                                ? SpinKitHourGlass(
                                    color: Color.fromARGB(255, 249, 106, 104))
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                          fit: BoxFit.fill,
                                          child: Image.network(
                                            sectors[1].featuredCourses[0].url,
                                            width: a * 0.6,
                                            height: b * 0.2,
                                          )),
                                      SizedBox(height: b * 0.01),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: a * 0.245,
                                            child: EllipsizedText(
                                              sectors[1].sectorName,
                                              style: TextStyle(
                                                  fontSize: a * 0.033,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 128, 126, 126)),
                                            ),
                                          ),
                                          Text(
                                            "₹" +
                                                sectors[1]
                                                    .featuredCourses[0]
                                                    .price,
                                            style: TextStyle(
                                                fontSize: a * 0.03,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: b * 0.01),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          FittedBox(
                                              child: SvgPicture.asset(
                                            "images/author.svg",
                                            height: b * 0.05,
                                          )),
                                       
                                          Column(
                                            children: [
                                              Text(
                                                  sectors[1]
                                                      .featuredCourses[1]
                                                      .author,
                                                  style: TextStyle(
                                                    overflow: TextOverflow.ellipsis
                                                    ,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  )),
                                              Text("4.1 star",
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w400,
                                                  )),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: b * 0.01),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      viewcourses(sectors[1]
                                                          .sectorUuid)));
                                        },
                                        child: Center(
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: SvgPicture.asset(
                                                  "images/view courses.svg",
                                                  width: a,
                                                ))),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 20, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(
                                0, 2), // changes the position of the shadow
                          )
                        ],
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: b * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Top Companies Trust by EduVerse",
                                  style: TextStyle(
                                    fontSize: a * 0.047,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: b * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "images/courses/1.png",
                                  scale: 20,
                                ),
                                Image.asset(
                                  "images/courses/micro.png",
                                  scale: 20,
                                ),
                              ],
                            ),
                            SizedBox(height: b * 0.02),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "images/courses/amazon.png",
                                  scale: 15,
                                ),
                                Image.asset(
                                  "images/courses/wipro.png",
                                  scale: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
