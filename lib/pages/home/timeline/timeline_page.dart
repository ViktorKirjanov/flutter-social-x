import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: TimelinePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timeline'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('TimelinePage'),
          ),
        ),
      ),
    );
  }
}
