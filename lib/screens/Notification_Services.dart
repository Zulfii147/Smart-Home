import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flashchat/screens/livingroom.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';



class NotificationServices{
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;
void requestnotificationpermission ()async {
NotificationSettings settings = await messaging.requestPermission(
alert: true,
announcement: true,
  badge: true,
    carPlay:true,
  criticalAlert: true,
  provisional: true,
  sound: true
);
if(settings.authorizationStatus==AuthorizationStatus.authorized){
  if (kDebugMode) {
    print("user granted permission");
  }
  
}
else if(settings.authorizationStatus==AuthorizationStatus.provisional){
  if (kDebugMode) {
    print("user granted provisional permission");
  }

}
else{
  if (kDebugMode) {
    print("user denied permission");
  }

}
}

void initlocalnotification(BuildContext context, RemoteMessage message)async{
  var androidInitializationSettings=const AndroidInitializationSettings('@mipmap/launcher_icon');
  //var iosInitializationSettings=const DarwinInitializationSettings();
  var initializationSettings=InitializationSettings(
      android: androidInitializationSettings,);
await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
onDidReceiveNotificationResponse: (payload){
  handleMessage(context, message);
});
}

 void firebaseInit(BuildContext context){

    FirebaseMessaging.onMessage.listen((message) {


      if (kDebugMode) {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
      if(Platform.isAndroid){
        initlocalnotification(context,message);
        showNotification(message);
      }

    });
  }

  Future<void> showNotification(RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(100000).toString(),'High Imporatance Notifications',
      importance: Importance.max
        // message.notification!.android!.channelId.toString(),
        // message.notification!.android!.channelId.toString() ,
        //     importance: Importance.max  ,
        //
        // showBadge: true ,
        // playSound: true,
        // sound: const RawResourceAndroidNotificationSound('jetsons_doorbell')


    );
    AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
        channel.id.toString(),
        channel.name.toString() ,
        channelDescription: 'your channel description',
        importance: Importance.high,
        priority: Priority.high ,
        playSound: true,
        ticker: 'ticker' ,
        //sound: channel.sound
      //     sound: RawResourceAndroidNotificationSound('jetsons_doorbell')
      //  icon: largeIconPath
    );

    // const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
    //     presentAlert: true ,
    //     presentBadge: true ,
    //     presentSound: true
    // ) ;

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        //iOS: darwinNotificationDetails
    );

    Future.delayed(Duration.zero , (){
      _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
      );
    });

  }


Future<String> getdevicetoken()async{
  String? token =await messaging.getToken();
return token!;


}
void savetoke(String token)async{
  await FirebaseFirestore.instance.collection("usertoken").add({'token' : token,});
}

void isTokenRefresh()async{
  messaging.onTokenRefresh.listen((event) {
    event.toString();
    print("refresh");
  });
}

  Future<void> setupInteractMessage(BuildContext context)async{

    // when app is terminated
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if(initialMessage != null){
      handleMessage(context, initialMessage);
    }


    //when app ins background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      handleMessage(context, event);
    });

  }

  void handleMessage(BuildContext context, RemoteMessage message) {

    if(message.data['type'] =='msj'){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const AuctionApp(

      )));
    }

  }

  void getTokens() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection(
          'usertoken').get();
      for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
        var token = documentSnapshot.data() ?? ['token'];

        if (kDebugMode) {
          print('Token: $token');


          var data = {
            'to': token.toString(),
            'notification': {
              'title': 'Asif',
              'body': 'Subscribe to my channel',
              "sound": "jetsons_doorbell.mp3"
            },
            // 'android': {
            //   'notification': {
            //     'notification_count': 23,
            //   },
            // },
            // 'data' : {
            //   'type' : 'msj' ,
            //   'id' : 'Asif Taj'
            // }
          };

          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              body: jsonEncode(data),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': 'key=AAAAQEjj0Mk:APA91bE7kGtIEY3nv-xmUhJHZdlgl54gScmR48fAz2g8aCUsneenjuL2U-qh9wT1t9MOTQEYGsoyY1GAx9cDpy5Br9EDmTuh3_UM1KdVsI3jUlAUUxBvfkIowzK78DaamJusEDFuuSqS'
              }
          ).then((token) {
            if (kDebugMode) {
              print(token.body.toString());
            }
          }).onError((error, stackTrace) {
            if (kDebugMode) {
              print(error);
            }
          });
        }
        // Perform actions with each token here
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching tokens: $e');
      }
    }


// Inside your class or widget

  }








}




