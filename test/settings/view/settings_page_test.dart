import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/home/profile/settings_page.dart';

void main() {
  group('SettingsPage', () {
    test('has a page', () {
      expect(SettingsPage.page(), isA<MaterialPage>());
    });

    testWidgets('finds SettingsPage widgets', (WidgetTester tester) async {
      const settingsPage = Key('SettingsPage');
      const logout = Key('logout');

      await tester.pumpWidget(
        const MaterialApp(
          home: SettingsPage(
            key: Key('SettingsPage'),
          ),
        ),
      );

      expect(find.byKey(settingsPage), findsOneWidget);
      expect(find.byKey(logout), findsOneWidget);
    });
  });
}
