import 'dart:convert';
import 'package:eduverse/model/cartmodel.dart';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;



class cart extends StatefulWidget {
  @override
  _cartState createState() => _cartState();
}

class _cartState extends State<cart> {
  Future<cartmodels?> fetchData() async {
    final response = await http
        .get(Uri.parse('https://courses-eduverse.onrender.com/courses/cart'));

    if (response.statusCode == 200) {
      return cartmodels.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var b = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '   My Cart',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<cartmodels?>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data!.data == null ||
              snapshot.data!.data!.isEmpty) {
            return Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                var course = snapshot.data!.data![index];
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Card(
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: InkWell(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  
                                  InkWell(
                                    // onTap: showimagepickeroption(context),
                                    child: Container(
                                      height: 0.04 * h,
                                      width: 0.04* b,
                                      
                                      decoration: BoxDecoration(
                                         color: Color.fromARGB(255, 255, 0, 0),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                 SizedBox(width: b*0.08,),
                                  Column(
                                    children: [
                                      Text(
                                        '  Author: ${course.author ?? ''}Anup',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      ),
                                      Text(
                                        '${course.title ?? ''}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.orange[900]),
                                      ),
                                      Text(
                                        '${course.price ?? ''}',
                                        style: TextStyle(
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
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

                // scoffold
              },
            );
          }
        },
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              child: FloatingActionButton(
                onPressed: () {
                  showimagepickeroption(context);
                },
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
              )),
        ],
      ),
    );
  }

  void showimagepickeroption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        height: MediaQuery.of(context).size.height / 16,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.blue),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue to payment  ",
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_circle_right,
                              size: 40,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              " Remove ",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Icon(
                              Icons.delete,
                              color: Colors.black,
                            )
                          ],
                        ))
                  ],
                ),
              ));
        });
  }
}