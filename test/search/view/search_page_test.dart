import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/search/search_page.dart';

void main() {
  group('SearchPage', () {
    test('has a page', () {
      expect(SearchPage.page(), isA<MaterialPage>());
    });
  });
}
