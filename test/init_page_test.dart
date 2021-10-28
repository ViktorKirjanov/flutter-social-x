import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:social_network_x/pages/init_page.dart';

void main() {
  testWidgets('finds HomePage widgets', (WidgetTester tester) async {
    const signinPage = Key('initPage');
    const signinButton = Key('signinButton11');
    const signupButton = Key('signupButton21');
    const googleButton = Key('googleButton31');

    await tester.pumpWidget(
      const MaterialApp(
        home: InitPage(
          key: Key('initPagex'),
        ),
      ),
    );

    expect(find.byKey(signinPage), findsOneWidget);
    expect(find.byKey(signinButton), findsOneWidget);
    expect(find.byKey(signupButton), findsOneWidget);
    expect(find.byKey(googleButton), findsOneWidget);
  });
}
