import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat/screens/Notification_Services.dart';
import 'package:flashchat/screens/announcement.dart';
import 'package:flashchat/screens/Bedroom.dart';
import 'package:flashchat/screens/schedule.dart';
import 'package:flashchat/screens/schedule_2.dart';
import 'package:flashchat/screens/voice.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuctionApp extends StatefulWidget {
  static const String id = 'bid';

  const AuctionApp({super.key});

  @override
  State<AuctionApp> createState() => _AuctionAppState();
}

class _AuctionAppState extends State<AuctionApp> {


  NotificationServices notificationServices=NotificationServices();
  @override
  void initState() {
    notificationServices.isTokenRefresh();
    notificationServices.firebaseInit(context);
    notificationServices.requestnotificationpermission();
    notificationServices.setupInteractMessage(context);
    notificationServices.getdevicetoken().then((value){

      print("Device");
      print(value);
      notificationServices.savetoke(value);
    });
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    try {
      await auth.signOut();
      // You can navigate to another page after sign out if needed
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );

    } catch (e) {
      print("Error signing out: $e");
    }
  }

  User? user = FirebaseAuth.instance.currentUser;
  late SharedPreferences _prefs;

  bool LED=false;
  bool fanOn=false;
  bool fanOn1=false;
  bool On1=false;
  final dbR= FirebaseDatabase.instance.ref();

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      // Retrieve the state of appliances from SharedPreferences
      LED = _prefs.getBool('LED') ?? false;
      fanOn = _prefs.getBool('fanOn') ?? false;
      fanOn1 = _prefs.getBool('fanOn1') ?? false;
      On1 = _prefs.getBool('On1') ?? false;
    });
  }

  Future<void> _savePreferences() async {
    // Save the state of appliances to SharedPreferences
    await _prefs.setBool('LED', LED);
    await _prefs.setBool('fanOn', fanOn);
    await _prefs.setBool('fanOn1', fanOn1);
    await _prefs.setBool('On1', On1);
  }


  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Padding(
          padding: EdgeInsets.only(left:90,top: 5),
          child: Text('Living Room'),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.search),
        //     onPressed: () {
        //       // Handle search action
        //     },
        //   ),
        // ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey,

        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title:
              const Text('Home' , style: TextStyle(color: Colors.white),),
              onTap: () {
                // Handle home tap
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.meeting_room),
              //Image.asset(
              // 'images/pubg.png',
              //width: 35, // adjust the size as needed
              // height: 100,
              //),
              title:
              const Text('BED ROOM', style: TextStyle(color: Colors.white),),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Admin()));

              },
            ),
            ListTile(
              leading: const Icon(Icons.schedule_outlined),
              title:
              const Text('Schedule Appliances of Living Room' , style: TextStyle(color: Colors.white),),

              onTap: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.keyboard_voice_outlined),
              title: const Text('Voice Control' , style: TextStyle(color: Colors.white),),
              onTap: () {
                // Handle settings tap
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              },
            ),
            //ListTile(
           //   leading: const Icon(Icons.settings),
            //  title:
            //  const Text('Announcements' , style: TextStyle(color: Colors.white),),
            //  onTap: () async{
              //  try {
                  // Get a reference to the Firestore collection
               //   CollectionReference users = FirebaseFirestore.instance.collection('registerdusers');

                  // Query the collection for the user's email
                //  QuerySnapshot querySnapshot = await users.where('registereduser', isEqualTo: user?.email).get();

                  // If there's a document with the user's email, perform the task
                //  if (querySnapshot.docs.isNotEmpty) {
                    // Perform your task here, for example:
                  //  Navigator.push(
                       // context,
                        //MaterialPageRoute(builder: (context) => const announcement()));
                    //print('User exists in registerdusers collection. Perform task...');
                //  } else {
                //    print('User does not exist in registerdusers collection.');
                  //}
              //  } catch (e) {
                  // Handle errors
               //   print('Error performing task: $e');
             //   }



                // Handle settings tap

             // },
           // ),
            ListTile(
              leading: const Icon(Icons.schedule),
              title:
              const Text('Schedule Appliances of Bed Room' , style: TextStyle(color: Colors.white),),
              onTap: (){
                // Handle settings tap
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => App()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.logout),
              title:
              const Text('Logout' , style: TextStyle(color: Colors.white),),
              onTap: () {
                signOut();
              },
            ),
            // Add more menu items as needed
          ],
        ),
      ),
      body: Column(
        children: [

          Positioned.fill(
            child: Image.asset(
              'images/living.jpg',
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
                        dbR.child("Light1").set({"Switch": !LED});
                        setState(() {
                          LED = !LED;
                          _savePreferences();
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
                              LED ? Icons.lightbulb : Icons.lightbulb,
                              size: 80,
                              color: LED ? Colors.yellow : Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(
                              LED ? 'Light On' : 'Light Off',
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
                        dbR.child("Light").set({"Switch": !On1});
                        setState(() {
                          On1 = !On1;
                          _savePreferences();
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
                              On1 ? Icons.lightbulb : Icons.lightbulb,
                              size: 80,
                              color: On1 ? Colors.yellow : Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(
                              On1 ? 'Light On' : 'Light Off',
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
                        dbR.child("Fan").set({"Switch": !fanOn});
                        setState(() {
                          fanOn = !fanOn;
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
                              fanOn ? Icons.mode_fan_off : Icons.flip_camera_android_sharp,
                              size: 80,
                              color: fanOn ? Colors.yellow : Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(
                              fanOn ? 'Fan On' : 'Fan Off',
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
                        dbR.child("AC").set({"Switch": !fanOn1});
                        setState(() {
                          fanOn1 = !fanOn1;
                          _savePreferences();
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
                              fanOn1 ? Icons.ac_unit : Icons.ac_unit_outlined,
                              size: 80,
                              color: fanOn1 ? Colors.yellow : Colors.grey,
                            ),
                            SizedBox(height: 5),
                            Text(
                              fanOn1 ? 'AC On' : 'AC Off',
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