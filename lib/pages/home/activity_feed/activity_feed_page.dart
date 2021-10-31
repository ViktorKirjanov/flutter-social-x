import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityFeedPage extends StatelessWidget {
  const ActivityFeedPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ActivityFeedPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ActivityFeedPage'),
      ),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: Text('ActivityFeedPage'),
          ),
        ),
      ),
    );
  }
}
