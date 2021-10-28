import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/init_page.dart';

void main() {
  testWidgets('finds HomePage widgets', (WidgetTester tester) async {
    const signinPage = Key('initPage');
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
    expect(find.byKey(signinButton), findsOneWidget);
    expect(find.byKey(signupButton), findsOneWidget);
    expect(find.byKey(googleButton), findsOneWidget);
  });
}
