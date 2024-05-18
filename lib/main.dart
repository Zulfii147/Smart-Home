import 'package:flashchat/screens/announcement.dart';
import 'package:flashchat/screens/livingroom.dart';
import 'package:flashchat/screens/Bedroom.dart';
import 'package:flashchat/screens/schedule.dart';
import 'package:flashchat/screens/schedule_2.dart';
import 'package:flashchat/screens/voice.dart';
import 'package:flutter/material.dart';
import 'package:flashchat/screens/welcome_screen.dart';
import 'package:flashchat/screens/login_screen.dart';
import 'package:flashchat/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
runApp(const FlashChat());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
   // ..customAnimation = CustomAnimation();
}

class FlashChat extends StatefulWidget {
  const FlashChat({super.key});


  @override
  State<FlashChat> createState() => _FlashChatState();
}

class _FlashChatState extends State<FlashChat> {
  var isLogin=false;

  var auth = FirebaseAuth.instance;

  checkiflogin()async{
    auth.authStateChanges().listen((User? user) {
      if(user !=null && mounted) {
        setState(() {
          isLogin=true;
        });
      }
      else{
        setState(() {
          isLogin = false;
        });
      }

    });

  }

  @override
  void initState() {
    checkiflogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData.dark().copyWith(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black54),
        ),
      ),


     home: isLogin ? const AuctionApp():const WelcomeScreen(),
      routes: {
        WelcomeScreen.id:(context) => const WelcomeScreen(),
        LoginScreen.id:(context) => const LoginScreen(),
        RegistrationScreen.id:(context) => const RegistrationScreen(),
        AuctionApp.id:(context)=> const AuctionApp(),
        Admin.id:(context)=> const Admin(),
        ApplianceSchedulerScreen.id:(context)=> const MyApp(),
        ApplianceScheduler.id:(context)=> const App(),
        MyHomePage.id:(context)=> MyHomePage(),
        announcement.id:(context)=>const announcement(),
      },
      builder: EasyLoading.init(),
    );
  }
}