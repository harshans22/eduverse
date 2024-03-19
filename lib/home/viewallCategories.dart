import 'package:eduverse/model/courses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eduverse/home/viewcourses.dart';
import 'dart:convert';
import 'package:eduverse/home/home.dart';
import 'package:ellipsized_text/ellipsized_text.dart';

Map harsh = {
  "Machine Learning": "images/courses/machine learning.jpg",
  "Flask": "images/courses/flask.webp",
  "Python": "images/courses/python.jpg",
  "Data Science": "images/courses/datascirnce.jpg",
  "Web Scraping": "images/courses/web scrapping.webp",
  "Node JS": "images/courses/nodejs.png",
  "Java Script": "images/courses/javascript.jpeg",
  "Programming Fundamentals Courses": "images/courses/programming.jpg",
  "Django": "images/courses/django.png",
  "HTML and CSS": "images/courses/htmlcss.jpg",
};

class viewallCategories extends StatefulWidget {
  List sectors;
  viewallCategories(this.sectors);

  @override
  State<viewallCategories> createState() => _viewallCategoriesState();
}

class _viewallCategoriesState extends State<viewallCategories> {
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text("Featured Courses"),
          backgroundColor: Color.fromARGB(255, 249, 106, 104),
        ),
        backgroundColor: Color.fromARGB(255, 243, 243, 247),
        body: SafeArea(
          child: GridView.builder(
              physics: ScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemCount: widget.sectors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(8),
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
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {},
                            child: FittedBox(
                                fit: BoxFit.cover,
                                child: Image.network(
                                  widget.sectors[index].sectorImage,
                                  width: a * 0.6,
                                  height: b * 0.2,
                                )),
                          ),
                          SizedBox(height: b * 0.01),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: a * 0.25,
                                child: EllipsizedText(
                                  widget.sectors[index].sectorName,
                                  style: TextStyle(
                                      fontSize: a * 0.033,
                                      fontWeight: FontWeight.w500,
                                      color:
                                          Color.fromARGB(255, 128, 126, 126)),
                                ),
                              ),
                              Text(
                                "₹" +
                                    widget.sectors[index].featuredCourses[0]
                                        .price,
                                style: TextStyle(
                                    fontSize: a * 0.03,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          SizedBox(height: b * 0.01),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                  child: SvgPicture.asset(
                                "images/author.svg",
                                height: b * 0.05,
                              )),
                             
                              Column(
                                children: [
                                  Text(
                                      widget.sectors[index].featuredCourses[0]
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
                                      builder: (context) => viewcourses(
                                          widget.sectors[index].sectorUuid)));
                            },
                            child: Center(
                              child: FittedBox(
                                  child: SvgPicture.asset(
                                "images/similar courses.svg",
                                width: a,
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ));
  }
}
