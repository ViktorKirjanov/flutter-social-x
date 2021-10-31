import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/home_page.dart';

void main() {
  group('HomePage', () {
    test('has a page', () {
      expect(HomePage.page(), isA<MaterialPage>());
    });

    testWidgets('finds HomePage widgets', (WidgetTester tester) async {
      const homePage = Key('HomePage');
      const timelineBottomItem = Key('timelineBottomItem');
      const activityFeedBottomItem = Key('activityFeedBottomItem');
      const createBottomItem = Key('createBottomItem');
      const searchBottomItem = Key('searchBottomItem');
      const profileBottomItem = Key('profileBottomItem');

      await tester.pumpWidget(
        MaterialApp(
          home: HomePage(
            key: const Key('HomePage'),
          ),
        ),
      );

      expect(find.byKey(homePage), findsOneWidget);
      expect(find.byKey(timelineBottomItem), findsOneWidget);
      expect(find.byKey(activityFeedBottomItem), findsOneWidget);
      expect(find.byKey(createBottomItem), findsOneWidget);
      expect(find.byKey(searchBottomItem), findsOneWidget);
      expect(find.byKey(profileBottomItem), findsOneWidget);
    });
  });
}
