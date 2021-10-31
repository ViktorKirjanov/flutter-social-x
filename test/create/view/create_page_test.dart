import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/create/create_page.dart';

void main() {
  group('CreatePage', () {
    test('has a page', () {
      expect(CreatePage.page(), isA<MaterialPage>());
    });
  });
}
