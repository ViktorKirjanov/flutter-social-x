import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/timeline/timeline_page.dart';

void main() {
  group('TimelinePage', () {
    test('has a page', () {
      expect(TimelinePage.page(), isA<MaterialPage>());
    });
  });
}
