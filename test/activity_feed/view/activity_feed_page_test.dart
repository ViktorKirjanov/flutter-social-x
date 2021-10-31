import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/activity_feed/activity_feed_page.dart';

void main() {
  group('ActivityFeedPage', () {
    test('has a page', () {
      expect(ActivityFeedPage.page(), isA<MaterialPage>());
    });
  });
}
