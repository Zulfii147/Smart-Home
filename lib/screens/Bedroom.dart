//import 'dart:io';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';


class Admin extends StatefulWidget {
  static const String id = 'Admin';

  const Admin({super.key});
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  bool bed_LED=false;
  bool bed_fanOn=false;
  bool bed_On1=false;
  bool bed_On=false;
  final dbR= FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.

        backgroundColor: Colors.blue,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: const Text("BED ROOM")),
      ),
        body: Column(
          children: [


            Positioned.fill(
              child: Image.asset(
                'images/bed.jpg',
                fit: BoxFit.cover,
              ),
            ),


            Flexible(
              // padding: const EdgeInsets.all(10),
              child: Row(

                //   mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(

                    child: Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          dbR.child("Light3").set({"Switch": !bed_LED});
                          setState(() {
                            bed_LED = !bed_LED;
                          });
                        },
                        child: Container(
                          height: 150,
                          color: Colors.blue,
                          padding: EdgeInsets.all(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bed_LED ? Icons.lightbulb : Icons.lightbulb,
                                size: 80,
                                color: bed_LED ? Colors.yellow : Colors.grey,
                              ),
                              SizedBox(height: 5),
                              Text(
                                bed_LED ? 'Light On' : 'Light Off',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Flexible(
                    child: Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          dbR.child("Light4").set({"Switch": !bed_On1});
                          setState(() {
                            bed_On1 = !bed_On1;
                          });
                        },
                        child: Container(
                          height: 150,
                          color: Colors.blue,
                          padding: EdgeInsets.all(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bed_On1 ? Icons.lightbulb : Icons.lightbulb,
                                size: 80,
                                color: bed_On1 ? Colors.yellow : Colors.grey,
                              ),
                              SizedBox(height: 5),
                              Text(
                                bed_On1 ? 'Light On' : 'Light Off',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(

                    child: Card(

                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          dbR.child("Fan2").set({"Switch": !bed_fanOn});
                          setState(() {
                            bed_fanOn = !bed_fanOn;
                          });
                        },
                        child: Container(
                          height: 150,
                          color: Colors.blue,
                          padding: EdgeInsets.all(3),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bed_fanOn ? Icons.ac_unit : Icons.ac_unit_outlined,
                                size: 80,
                                color: bed_fanOn ? Colors.yellow : Colors.grey,
                              ),
                              SizedBox(height: 5),
                              Text(
                                bed_fanOn ? 'Fan On' : 'Fan Off',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Card(
                      elevation: 5,
                      child: InkWell(
                        onTap: () {
                          dbR.child("Fan3").set({"Switch": !bed_fanOn});
                          setState(() {
                            bed_fanOn = !bed_fanOn;
                          });
                        },
                        child: Container(
                          height: 150,
                          color: Colors.blue,
                          padding: EdgeInsets.all(3),
                          child: Column(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                bed_fanOn ? Icons.ac_unit : Icons.ac_unit_outlined,
                                size: 80,
                                color: bed_fanOn ? Colors.yellow : Colors.grey,
                              ),
                              SizedBox(height: 5),
                              Text(
                                bed_fanOn ? 'Fan On' : 'Fan Off',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //Text(

            // 'BED ROOM',
            // style: TextStyle(
            //   fontSize: 20,
            //  fontWeight: FontWeight.bold,
            // ),
            //  ),

            //Positioned.fill(
            // child: Image.asset(
            // 'images/bed.jpg',
            // fit: BoxFit.cover,
            //),
            // ),
          ],


        ),

    );
  }
}