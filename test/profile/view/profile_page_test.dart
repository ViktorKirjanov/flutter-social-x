import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/profile/profile_page.dart';

void main() {
  group('ProfilePage', () {
    test('has a page', () {
      expect(ProfilePage.page(), isA<MaterialPage>());
    });
  });
}
