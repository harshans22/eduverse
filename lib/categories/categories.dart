import 'dart:convert';

import 'package:eduverse/course_details/coursedetails.dart';
import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter/material.dart';
import 'package:eduverse/model/viewcourses.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:eduverse/model/courses.dart';

Map cat = {
  "AI & ML": "AI & ML",
  "Block chain": "Block Chain",
  "Cloud Computing": "Cloud Computing",
  "Web Scraping": "Web Scrapping",
  "React JS": "React JS",
  "Java Script": "Java Script",
  "Data structure and algorithms": "DSA",
  "Django": "Django",
  "HTML and CSS": "HTMl & CSS",
};


class categoires extends StatefulWidget {
  const categoires({super.key});

  @override
  State<categoires> createState() => _categoriesState();
}

// Widget categories() {
//   return Scaffold(
//     body: Text('harsh'),
//   );
// }

class _categoriesState extends State<categoires> {
  bool isloading = true;
//api for courses based on sectoruuid
  List<Sector2> view = [];
  Future<void> fetchcourses(String query) async {
    String url = "https://eduverse-h05r.onrender.com/courses/$query/";
    var response = await get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    setState(() {
      view = [Sector2.fromJson(data)];// clear previous data and add new data
      
      isloading = false;
    });
  }

  //api for viewcourses based on chips
  List<Sector> sectors = [];
  Future<void> fetchData() async {
    String url = "https://eduverse-h05r.onrender.com/courses/";
    var response = await get(Uri.parse(url));
    List<dynamic> data = json.decode(response.body);
    setState(() {
      sectors = data.map((sector) => Sector.fromJson(sector)).toList();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    // fetchcourses("a2cfe225-706d-425e-9be5-33e9ad2cc282");
  }

  int value = -1;
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("categories"),
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
      ),
      backgroundColor: Color(0xFFE5E5E7),
      body: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
             
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                child: Row(
                  children: [
                    Text(
                      "Filters",
                      style: TextStyle(
                          fontSize: a * 0.08,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 244, 73, 54)),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    height: b * 0.07,
                    width: a,
                    child: ListView.builder(
                      itemCount: sectors.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 51, 52, 52)
                                      .withOpacity(0.5),
                                  spreadRadius: 0,
                                  blurRadius: 10,
                                  offset: Offset(0,
                                      2), // changes the position of the shadow
                                )
                              ],
                            ),
                            child: ChoiceChip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              side: BorderSide(color: const Color.fromARGB(255, 103, 103, 103)),
                              label: EllipsizedText(
                                  cat[sectors[index].sectorName]),
                              labelStyle: TextStyle(color: Colors.white),
                              onSelected: (bool selected) {
                                setState(() {
                                  value = (selected ? index : null)!;

                                  fetchcourses(sectors[value].sectorUuid);
                                });
                              },
                              selected: value == index,
                              backgroundColor: value == index
                                  ? Color.fromARGB(255, 211, 42, 42)
                                  : Color.fromARGB(232, 50, 122, 210),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              isloading
                  ? Center(
                      child: Lottie.asset("images/anima.json"),
                    )
                  : Expanded(
                    child: ListView.builder(// for view courses
                                  itemCount: view[0].data.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: SafeArea(
                        child: Container(
                            height: b * 0.31,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 154, 152, 152)
                                      .withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(
                                      0, 2), // changes the position of the shadow
                                )
                              ],
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: BorderRadiusDirectional.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                       width: a * 0.4,
                                        height: b * 0.15,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Image.network(
                                          view[0].data[index].url,
                                        ),
                                      ),
                                      SizedBox(width: a * 0.02),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              view[0].data[index].title,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                              style: TextStyle(
                                                  fontSize: a * 0.045,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: b * 0.005,
                                            ),
                                            Text(
                                              "By " +
                                                  view[0].data[index].author,
                                              style: TextStyle(
                                                  fontSize: a * 0.05,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 233, 145, 12)),
                                            ),
                                            SizedBox(
                                              height: b * 0.005,
                                            ),
                                            Text(
                                              "₹" + view[0].data[index].price,
                                              style: TextStyle(
                                                  fontSize: a * 0.04,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 233, 45, 12)),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: b * 0.005,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          view[0].data[index].description,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: a * 0.045,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.grey),
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  Row(
                                    children: [ 
                                      InkWell(
                                        child: Expanded(child: SvgPicture.asset("images/add to cart.svg",width: a,height: b*0.05,))),
                                        SizedBox(width: a*0.1,),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        coursedetails(view[0]
                                                            .data[index]
                                                            .courseUuid)));
                                          },
                                          child: Text("Details>>",style: TextStyle(fontSize: a*0.045,fontWeight: FontWeight.w500), )),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                      ),
                    );
                                  }),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
