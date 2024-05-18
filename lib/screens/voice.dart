import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Voice());
}

class Voice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assistant Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String id = 'voice';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final reference = FirebaseDatabase.instance.ref();
  final speechToText = stt.SpeechToText();
  bool isListening = false;
  stt.SpeechToText _speech = stt.SpeechToText();
  String transcription = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    initSpeechState();
  }

  void initSpeechState() async {
    bool available = await _speech.initialize(
      onStatus: (status) => print('status: $status'),
      onError: (error) => print('error: $error'),
    );
    if (available) {
      setState(() => isListening = true);
      _speech.listen(
        onResult: (result) => setState(() {
          transcription = result.recognizedWords;
          _controller.text = transcription;
          processUserCommand(transcription);
        }),
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }

  void processUserCommand(String command) {
    if (command.toLowerCase().contains("turn on the light")) {
      reference.child('Light/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off the light")) {
      reference.child('Light/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on the tubelight")) {
      reference.child('Light1/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off the tubelight")) {
    reference.child('Light1/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on the fan")) {
      reference.child('Fan/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off the fan")) {
      reference.child('Fan/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on the exhaust")) {
      reference.child('Exhaust/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off the exhaust")) {
      reference.child('Exhaust/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on bed room fan")) {
      reference.child('Fan1/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off bed room fan")) {
      reference.child('Fan1/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on bed room light")) {
      reference.child('Bed_Light/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off bed room light")) {
      reference.child('Bed_Light/Switch').set(false);
    }

    if (command.toLowerCase().contains("turn on bed room tubelight")) {
      reference.child('Bed_Light1/Switch').set(true);
    }
    else if (command.toLowerCase().contains("turn off bed room tubelight")) {
      reference.child('Bed_Light1/Switch').set(false);
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Voice Assistant'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _controller,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Transcription',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (isListening) {
                    _speech.stop();
                    isListening = false;
                  } else {
                    _speech.listen(
                      onResult: (result) => setState(() {
                        transcription = result.recognizedWords;
                        _controller.text = transcription;
                        processUserCommand(transcription);
                      }),
                    );
                    isListening = true;
                  }
                });
              },
              child: Text(isListening ? 'Stop Listening' : 'Start Listening'),
            ),
          ],
        ),
      ),
    );
  }
}
