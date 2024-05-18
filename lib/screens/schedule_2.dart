import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key});

  @override  static const String id = 'app';

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appliance Scheduler',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApplianceScheduler(),
    );
  }
}

class ApplianceScheduler extends StatefulWidget {
  static const String id = 'app1';
  const ApplianceScheduler({Key? key});

  @override
  _ApplianceSchedulerState createState() => _ApplianceSchedulerState();
}

class _ApplianceSchedulerState extends State<ApplianceScheduler> {
  final DatabaseReference _lightRef = FirebaseDatabase.instance.ref().child('Bed_Light');
  final DatabaseReference _fanRef = FirebaseDatabase.instance.ref().child('Bed_Light1');
  final DatabaseReference _acRef = FirebaseDatabase.instance.ref().child('Fan1');
  final DatabaseReference _tvRef = FirebaseDatabase.instance.ref().child('Fan2');

  Timer? _lightTimer;
  Timer? _fanTimer;
  Timer? _acTimer;
  Timer? _tvTimer;
  DateTime? _selectedDateTime;

  void _scheduleApplianceChange(
      bool turnOn, DateTime scheduledDateTime, DatabaseReference ref) {
    final currentTime = DateTime.now();
    final difference = scheduledDateTime.difference(currentTime);
    if (difference.isNegative) {
      print('Selected time should be in the future.');
      return;
    }

    Timer? timer;
    if (ref == _lightRef) {
      timer = _lightTimer;
    } else if (ref == _fanRef) {
      timer = _fanTimer;
    } else if (ref == _acRef) {
      timer = _acTimer;
    } else if (ref == _tvRef) {
      timer = _tvTimer;
    }

    timer?.cancel();
    timer = Timer(difference, () {
      _updateApplianceStatus(turnOn, ref);
    });
  }

  Future<void> _updateApplianceStatus(bool turnOn, DatabaseReference ref) async {
    await ref.set({'Switch': turnOn});
    print('${ref.key} is turned ${turnOn ? 'on' : 'off'}');
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Appliance Scheduler')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _selectDateTime(context);
              },
              child: const Text('Select Date and Time'),
            ),
            const SizedBox(height: 20),
            if (_selectedDateTime != null) ...[
              Text(
                'Scheduled Date and Time: ${DateFormat('yyyy-MM-dd HH:mm').format(_selectedDateTime!)}',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(true, _selectedDateTime!, _lightRef);
                },
                child: const Text('Schedule Light to Turn On'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(false, _selectedDateTime!, _lightRef);
                },
                child: const Text('Schedule Light to Turn Off'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(true, _selectedDateTime!, _fanRef);
                },
                child: const Text('Schedule TubeLight to Turn On'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(false, _selectedDateTime!, _fanRef);
                },
                child: const Text('Schedule TubeLight to Turn Off'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(true, _selectedDateTime!, _acRef);
                },
                child: const Text('Schedule Fan to Turn On'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(false, _selectedDateTime!, _acRef);
                },
                child: const Text('Schedule Fan to Turn Off'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(true, _selectedDateTime!, _tvRef);
                },
                child: const Text('Schedule Pedestar to Turn On'),
              ),
              ElevatedButton(
                onPressed: () {
                  _scheduleApplianceChange(false, _selectedDateTime!, _tvRef);
                },
                child: const Text('Schedule Pedestar to Turn Off'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
