import 'package:eduverse/model/viewcourses.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eduverse/course_details/coursedetails.dart';

class viewcourses extends StatefulWidget {
  String sectoruuid;
  viewcourses(this.sectoruuid);

  @override
  State<viewcourses> createState() => _viewcoursesState();
}

class _viewcoursesState extends State<viewcourses> {
  bool isloading = true;

  List<Sector2> view = [];
  Future<void> fetchcourses(String query) async {
    String url = "https://eduverse-h05r.onrender.com/courses/$query/";
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
    fetchcourses(widget.sectoruuid);
  }

  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 236, 236, 237),
        appBar: AppBar(
          title: Text("overview"),
          backgroundColor: Color.fromARGB(255, 249, 106, 104),
        ),
        body: isloading
            ? SpinKitPouringHourGlass(color: Colors.red)
            : ListView.builder(
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
                })
                );
  }
}
