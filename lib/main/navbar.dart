import 'package:eduverse/cart/add_to_cart.dart';
import 'package:eduverse/enrolled/enrolled.dart';
import 'package:flutter/material.dart';

import 'package:eduverse/categories/categories.dart';

import 'package:eduverse/profile/profile.dart';

import 'package:eduverse/home/home.dart';

class navbar extends StatefulWidget {
  const navbar({super.key});

  @override
  State<navbar> createState() => _navbarState();
}

class _navbarState extends State<navbar> {
  int myindex = 0;
   List<Widget> screens =  [
   home(),
    categoires(),
    cart(),
    profile(),
  ];

  @override
  Widget build(BuildContext context) {
    // var a = MediaQuery.of(context).size.width;
    // var b = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      enrolled()));
      },
      backgroundColor:Color.fromARGB(237, 231, 83, 120) ,
      elevation: 10,
      child: Icon(Icons.add_task),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        children: screens,
        index: myindex,
      ),
      backgroundColor: Color(0xFFE5E5E7),
      bottomNavigationBar: BottomNavigationBar(
backgroundColor: Color.fromARGB(255, 255, 254, 254),
        type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
                 myindex = index;
            }); 
          },
          currentIndex: myindex,
          selectedItemColor: Color(0xFFFF647D),
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem( label: "",
              icon:  Padding(
                padding: const EdgeInsets.only(top:0,bottom: 0),
                child: Icon(Icons.home,size: 30),
              ),  
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top:0,bottom: 0),
                child: Icon(Icons.calendar_month, size: 30),
              ),
              label: "",
            ),
          
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top:0,bottom: 0),
                child: Icon(Icons.shopping_cart,size: 30),
              ),
              label: "",
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top:0,bottom: 0),
                child: Icon(Icons.person,size: 30,),
                
              ),
              label: "",
            ),
            
          ]
          ),
    );
  }
}