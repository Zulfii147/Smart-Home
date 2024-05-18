import 'package:flutter/material.dart';


class announcement extends StatefulWidget {
  const announcement({super.key});
  static const String id = 'ann';
  @override
  State<announcement> createState() => _announcementState();
}

class _announcementState extends State<announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Title'),
      ),
      body: const Center(
        child: Text('Your Page Content Here'),
      ),
    );
  }
}

