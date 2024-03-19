
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:eduverse/model/search.dart';
import 'package:eduverse/course_details/coursedetails.dart';

class searchdata extends StatefulWidget {
  String name;
  searchdata(this.name);

  @override
  State<searchdata> createState() => _searchdataState();
}

class _searchdataState extends State<searchdata> {
  List<search> sear = [];
bool isloading = false;

Future<void> fetchsearch(String query) async {
  String url = "https://eduverse-h05r.onrender.com/courses/search/$query/";
  var response = await get(Uri.parse(url));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);

    setState(() {
      sear = data.map((courseData) => search.fromJson(courseData)).toList();
      isloading = false;
    });
  } else {
    // Handle error, e.g., show an error message
    print("Failed to load data: ${response.statusCode}");
  }
}


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsearch(widget.name);
  }

  @override
  Widget build(BuildContext context) {
     var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 238, 250),
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
      ),
      body: SafeArea(child: isloading
            ? SpinKitPouringHourGlass(color: Colors.red)
            : ListView.builder(
                itemCount: sear.length,
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
                                      child: Image.network(
                                          sear[index].url),
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
                                            sear[index].title,
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
                                                sear[index].author,
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
                                            "₹" + sear[index].price,
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
                                        sear[index].description,
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
                                      onTap: (){
                                        
                                      },
                                      child: Expanded(child: SvgPicture.asset("images/add to cart.svg",width: a,height: b*0.05,))),
                                      SizedBox(width: a*0.1,),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      coursedetails(sear[index].courseUuid)));
                                        },
                                        child: Text("Details>>",style: TextStyle(fontSize: a*0.045,fontWeight: FontWeight.w500), )),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  );
                })),
    );
  }
}
