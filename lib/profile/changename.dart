import 'package:eduverse/profile/profile.dart';

import 'package:flutter/material.dart';

class changename extends StatefulWidget {
  const changename({super.key});

  @override
  State<changename> createState() => _changenameState();
}

class _changenameState extends State<changename> {
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Change Name"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Enter Name",
                    
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.blue), // Set default border color
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => profile(username: nameController.text,),
                          ));
                    },
                    child: Text("Change Name")),
              ]),
            ]),
          ),
        ));
  }
}
