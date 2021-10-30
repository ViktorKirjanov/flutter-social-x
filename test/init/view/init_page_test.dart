import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/init_page/init_page.dart';

void main() {
  group('InitPage', () {
    test('has a page', () {
      expect(InitPage.page(), isA<MaterialPage>());
    });

    testWidgets('finds InitPage widgets', (WidgetTester tester) async {
      const signinPage = Key('initPage');
      const logoIcon = Key('logoIcon');
      const signinButton = Key('signinButton');
      const signupButton = Key('signupButton');
      const googleButton = Key('googleButton');

      await tester.pumpWidget(
        const MaterialApp(
          home: InitPage(
            key: Key('initPage'),
          ),
        ),
      );

      expect(find.byKey(signinPage), findsOneWidget);
      expect(find.byKey(logoIcon), findsOneWidget);
      expect(find.byKey(signinButton), findsOneWidget);
      expect(find.byKey(signupButton), findsOneWidget);
      expect(find.byKey(googleButton), findsOneWidget);
    });
  });
}
