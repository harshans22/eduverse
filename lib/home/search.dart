import 'dart:math';


import 'package:eduverse/home/searchdisplay.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:ellipsized_text/ellipsized_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class search extends StatefulWidget {
  const search({super.key});

  @override
  State<search> createState() => _searchState();
}
List<String> searchlist = ["The Ultimate Flask Course","REST APIs with Flask","NodeJS Tutorial and Projects Course","The Web Developer Bootcamp 2023"];
 var name = [
    "Graphic design",
    "Java and DSA",
    "Web Development",
    "App development",
    "Artificial Intelligence"
  ];
  final random =new Random();
  var item = name[random.nextInt(name.length)];
class _searchState extends State<search> {
  TextEditingController searchController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    var a = MediaQuery.of(context).size.width;
    var b = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 223, 238, 250),
      appBar: AppBar(
        title: Text("Search Your Courses"),
        backgroundColor: Color.fromARGB(255, 249, 106, 104),
      ),
      body: Padding(
        padding: EdgeInsets.all(25.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SafeArea(
                  child: Center(
                    child: Container(
                      height: b * 0.08,
                      width: a,
                      //Search Wala Container
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                             Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          searchdata(searchController.text)));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: SvgPicture.asset(
                                  "images/searchbarIcon.svg",
                                  height: b * 0.06,
                                ),
                                margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "$item",
                                hintStyle: TextStyle(fontSize: a*0.05,color:Colors.grey,fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ),
              SizedBox(height: b*0.03,),
              Row(
                children: [
                  Text("Recent Searches",style: TextStyle(fontSize:a*0.05,fontWeight: FontWeight.w500),),  
                  ] ,
              ),
              SizedBox(height: b*0.04,),
              Row(
                children: [
                  Column( crossAxisAlignment: CrossAxisAlignment.start,
                 
                    children: [
                      Container(width:a*0.8,
                        child: EllipsizedText(searchlist[0],style: TextStyle(fontSize:a*0.04,fontWeight: FontWeight.w500,color: Colors.grey))),
                       SizedBox(height: b*0.04,),
                      Container(width:a*0.8,
                        child: EllipsizedText(searchlist[1],style: TextStyle(fontSize:a*0.04,fontWeight: FontWeight.w500,color: Colors.grey))),
                      SizedBox(height: b*0.04,),
                      Container(width:a*0.8,
                        child: EllipsizedText(searchlist[2],style: TextStyle(fontSize:a*0.04,fontWeight: FontWeight.w500,color: Colors.grey))),
                      SizedBox(height: b*0.04,),
                      Container(
                        width:a*0.8,
                        child: EllipsizedText(searchlist[3],style: TextStyle(fontSize:a*0.04,fontWeight: FontWeight.w500,color: Colors.grey))),
                    ],
                  ),
                ],
              ),
             
            ],
          ),  
        ),
      ),
    );
  }
}
